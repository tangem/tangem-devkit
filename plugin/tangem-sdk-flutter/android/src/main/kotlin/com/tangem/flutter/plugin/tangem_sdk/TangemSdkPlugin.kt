package com.tangem.flutter.plugin.tangem_sdk

import android.app.Activity
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import com.squareup.moshi.FromJson
import com.squareup.moshi.ToJson
import com.tangem.*
import com.tangem.common.CompletionResult
import com.tangem.common.card.FirmwareVersion
import com.tangem.common.core.CardSession
import com.tangem.common.core.Config
import com.tangem.common.core.TangemError
import com.tangem.common.core.TangemSdkError
import com.tangem.common.extensions.hexToBytes
import com.tangem.common.files.DataToWrite
import com.tangem.common.files.FileDataProtectedByPasscode
import com.tangem.common.files.FileDataProtectedBySignature
import com.tangem.common.files.FileSettingsChange
import com.tangem.common.json.MoshiJsonConverter
import com.tangem.common.services.secure.SecureStorage
import com.tangem.operations.PreflightReadMode
import com.tangem.operations.PreflightReadTask
import com.tangem.tangem_sdk_new.DefaultSessionViewDelegate
import com.tangem.tangem_sdk_new.NfcLifecycleObserver
import com.tangem.tangem_sdk_new.extensions.createLogger
import com.tangem.tangem_sdk_new.extensions.localizedDescription
import com.tangem.tangem_sdk_new.nfc.NfcManager
import com.tangem.tangem_sdk_new.storage.create
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.plugins.lifecycle.HiddenLifecycleReference
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.lang.ref.WeakReference
import java.util.*

/** TangemSdkPlugin */
class TangemSdkPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {

  private val handler = Handler(Looper.getMainLooper())
  private lateinit var wActivity: WeakReference<Activity>

  private lateinit var sdk: TangemSdk
  private var cardSession: CardSession? = null

  private var replyAlreadySubmit = false

  override fun onAttachedToActivity(pluginBinding: ActivityPluginBinding) {
    val activity = pluginBinding.activity
    wActivity = WeakReference(activity)

    val nfcManager = createNfcManager(pluginBinding)
    val config = Config().apply {
      linkedTerminal = false
      filter.allowedCardTypes = listOf(FirmwareVersion.FirmwareType.Sdk)
    }
    sdk = TangemSdk(
        nfcManager.reader,
        createViewDelegate(activity, nfcManager),
        SecureStorage.create(activity),
        config,
    )
    Log.addLogger(TangemSdk.createLogger())
  }

  private fun createNfcManager(pluginBinding: ActivityPluginBinding): NfcManager {
    val hiddenLifecycleReference: HiddenLifecycleReference = pluginBinding.lifecycle as HiddenLifecycleReference
    return NfcManager().apply {
      setCurrentActivity(pluginBinding.activity)
      hiddenLifecycleReference.lifecycle.addObserver(NfcLifecycleObserver(this))
    }
  }

  private fun createViewDelegate(activity: Activity, nfcManager: NfcManager): SessionViewDelegate =
      DefaultSessionViewDelegate(nfcManager, nfcManager.reader).apply { this.activity = activity }

  override fun onDetachedFromActivity() {
  }

  override fun onReattachedToActivityForConfigChanges(pluginBinding: ActivityPluginBinding) {
    wActivity = WeakReference(pluginBinding.activity)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    wActivity = WeakReference(null)
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    val messenger = flutterPluginBinding.binaryMessenger
    MethodChannel(messenger, "tangemSdk").setMethodCallHandler(this)
    MethodChannel(messenger, "tangemSdk_JSONRPC").setMethodCallHandler(this)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    replyAlreadySubmit = false
    when (call.method) {
      "startSession" -> startSession(call, result)
      "stopSession" -> stopSession(call, result)
      "runJSONRPCRequest" -> runJSONRPCRequest(call, result)
      "allowsOnlyDebugCards" -> allowsOnlyDebugCards(call, result)
      "loadCardInfo" -> loadCardInfo(call, result)
      "attestCard" -> attestCard(call, result)
      "readIssuerData" -> readIssuerData(call, result)
      "writeIssuerData" -> writeIssuerData(call, result)
      "readIssuerExData" -> readIssuerExtraData(call, result)
      "writeIssuerExData" -> writeIssuerExtraData(call, result)
      "readUserData" -> readUserData(call, result)
      "writeUserData" -> writeUserData(call, result)
      "writeUserProtectedData" -> writeUserProtectedData(call, result)
      "writeFiles" -> writeFiles(call, result)
      "readFiles" -> readFiles(call, result)
      "deleteFiles" -> deleteFiles(call, result)
      "changeFilesSettings" -> changeFilesSettings(call, result)
      "prepareHashes" -> prepareHashes(call, result)
      "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      else -> result.notImplemented()
    }
  }

  private fun startSession(call: MethodCall, result: Result) {
    try {
      if (cardSession != null && cardSession !!.state == CardSession.CardSessionState.Active)
        throw PluginException("The CardSession has already started")

      sdk.startSession(
          call.extractOptional("cardId"),
          call.extractOptional("initialMessage"),
      ) { session, error ->
        if (error == null) {
          cardSession = session
          handleResult(result, CompletionResult.Success<Any>(true))
        } else {
          cardSession = null
          handleResult(result, CompletionResult.Failure<Any>(error))
        }
      }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun stopSession(call: MethodCall, result: Result) {
    try {
      val session = cardSession ?: throw PluginException("Session not started")
      val errorMessage: String? = call.extractOptional("error")
      if (errorMessage == null) {
        session.stop()
      } else {
        session.stopWithError(CustomTangemSdkError(errorMessage))
      }

      cardSession = null
      handleResult(result, CompletionResult.Success<Any>(true))
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun runJSONRPCRequest(call: MethodCall, result: Result) {
    try {
      replyAlreadySubmit = false
      val stringOfJSONRPCRequest = call.extract<String>("JSONRPCRequest")

      val callback = callbackWithResult@{ response: String ->
        if (! replyAlreadySubmit) {
          replyAlreadySubmit = true
          handler.post { result.success(response) }
        }
      }

      if (cardSession == null) {
        sdk.startSessionWithJsonRequest(
            stringOfJSONRPCRequest,
            call.extractOptional("cardId"),
            call.extractOptional("initialMessage"),
            callback
        )
      } else {
        cardSession !!.run(stringOfJSONRPCRequest, callback)
      }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun handleResult(result: Result, completionResult: CompletionResult<*>) {
    if (replyAlreadySubmit) return
    replyAlreadySubmit = true

    when (completionResult) {
      is CompletionResult.Success -> {
        handler.post { result.success(converter.toJson(completionResult.data)) }
      }
      is CompletionResult.Failure -> {
        val error = completionResult.error
        val errorMessage = if (error is TangemSdkError) {
          val activity = wActivity.get()
          if (activity == null) error.customMessage else error.localizedDescription(activity)
        } else {
          error.customMessage
        }
        val pluginError = PluginError(error.code, errorMessage)
        handler.post {
          result.error("${error.code}", errorMessage, converter.toJson(pluginError))
        }
      }
    }
  }

  private fun handleException(result: Result, ex: Exception) {
    if (replyAlreadySubmit) return
    replyAlreadySubmit = true

    val exception = ex as? PluginException ?: TangemSdkException(ex)
    handler.post {
      val code = 1000
      val localizedDescription: String = exception.toString()
      result.error("$code", localizedDescription,
          converter.toJson(PluginError(code, localizedDescription)))
    }
  }

  private fun loadCardInfo(call: MethodCall, result: Result) {
    try {
      sdk.loadCardInfo(
          call.extract("cardPublicKey"),
          call.extract("cardId"),
      ) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun attestCard(call: MethodCall, result: Result) {
    try {
      //      val command = AttestationTask(
      //          call.extract("mode"),
      //          trustedCardsRepo = xxx
      //      )
      //      sdk.startSessionWithRunnable(
      //          command,
      //          call.extractOptional("cardId"),
      //          call.extractOptional("initialMessage"),
      //      ) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun readIssuerData(call: MethodCall, result: Result) {
    try {
      sdk.readIssuerData(
          call.extractOptional("cardId"),
          call.extractOptional("initialMessage")
      ) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun writeIssuerData(call: MethodCall, result: Result) {
    try {

      sdk.writeIssuerData(
          call.extractOptional("cardId"),
          call.extract("issuerData"),
          call.extract("issuerDataSignature"),
          call.extractOptional("issuerDataCounter"),
          call.extractOptional("initialMessage")
      ) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun readIssuerExtraData(call: MethodCall, result: Result) {
    try {
      sdk.readIssuerExtraData(
          call.extractOptional("cardId"),
      ) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun writeIssuerExtraData(call: MethodCall, result: Result) {
    try {
      sdk.writeIssuerExtraData(
          call.extractOptional("cardId"),
          call.extract("issuerData"),
          call.extract("startingSignature"),
          call.extract("finalizingSignature"),
          call.extractOptional("issuerDataCounter"),
          call.extractOptional("initialMessage"),
      ) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun readUserData(call: MethodCall, result: Result) {
    try {
      sdk.readUserData(
          call.extractOptional("cardId"),
          call.extractOptional("initialMessage")
      ) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun writeUserData(call: MethodCall, result: Result) {
    try {
      sdk.writeUserData(
          call.extract("userData"),
          call.extractOptional("cardId"),
          call.extractOptional("userCounter"),
          call.extractOptional("initialMessage")
      ) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun writeUserProtectedData(call: MethodCall, result: Result) {
    try {
      sdk.writeUserProtectedData(
          call.extract("userProtectedData"),
          call.extractOptional("cardId"),
          call.extractOptional("userProtectedCounter"),
          call.extractOptional("initialMessage")
      ) {
        handleResult(result, it)
      }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun writeFiles(call: MethodCall, result: Result) {
    try {
      val writeFiles: FileCommand.Write = converter.fromJson(converter.toJson(call.arguments)) !!
      sdk.writeFiles(
          writeFiles.files,
          call.extractOptional("cardId"),
          call.extractOptional("initialMessage")
      ) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun readFiles(call: MethodCall, result: Result) {
    try {
      val readFiles: FileCommand.Read = converter.fromJson(converter.toJson(call.arguments)) !!
      sdk.readFiles(
          readFiles.readPrivateFiles,
          readFiles.indices,
          call.extractOptional("cardId"),
          call.extractOptional("initialMessage")
      ) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun deleteFiles(call: MethodCall, result: Result) {
    try {
      val deleteFiles: FileCommand.Delete = converter.fromJson(converter.toJson(call.arguments)) !!
      sdk.deleteFiles(
          deleteFiles.indices,
          call.extractOptional("cardId"),
          call.extractOptional("initialMessage")
      ) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun changeFilesSettings(call: MethodCall, result: Result) {
    try {
      val changeSettings: FileCommand.ChangeSettings = converter.fromJson(converter.toJson(call.arguments)) !!
      sdk.changeFilesSettings(
          changeSettings.changes,
          call.extractOptional("cardId"),
          call.extractOptional("initialMessage")
      ) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun prepareHashes(call: MethodCall, result: Result) {
    try {
      val fileHasData = sdk.prepareHashes(
          call.extract("cardId"),
          call.extract("fileData"),
          call.extract("fileCounter"),
          call.extract("privateKey"),
      )
      handleResult(result, CompletionResult.Success(fileHasData))
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun allowsOnlyDebugCards(call: MethodCall, result: Result) {
    try {
      val allowedOnlyDebug: Boolean = call.extract("isAllowedOnlyDebugCards")
      val allowedCardTypes = if (allowedOnlyDebug) {
        listOf(FirmwareVersion.FirmwareType.Sdk)
      } else {
        FirmwareVersion.FirmwareType.values().toList()
      }
      sdk.config.filter.allowedCardTypes = allowedCardTypes
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  @Throws(PluginException::class)
  inline fun <reified T> MethodCall.extract(name: String): T {
    return try {
      this.extractOptional(name) ?: throw PluginException("MethodCall.extract: no such field: $name, or field is NULL")
    } catch (ex: Exception) {
      throw ex as? PluginException ?: PluginException("MethodCall.extractOptional", ex)
    }
  }

  inline fun <reified T> MethodCall.extractOptional(name: String): T? {
    if (! this.hasArgument(name)) return null
    val argument = this.argument<Any>(name) ?: return null

    if (argument is String && T::class.java == ByteArray::class.java) {
      return argument.hexToBytes() as T
    }

    return if (argument is String) {
      argument as T
    } else {
      val json = converter.toJson(argument)
      converter.fromJson<T>(json) !!
    }
  }

  companion object {
    val converter = createMoshiJsonConverter()

    private fun createMoshiJsonConverter(): MoshiJsonConverter {
      val adapters = MoshiJsonConverter.getTangemSdkAdapters().toMutableList()
      adapters.add(MoshiAdapters.DataToWriteAdapter())
      adapters.add(MoshiAdapters.DataProtectedBySignatureAdapter())
      adapters.add(MoshiAdapters.DataProtectedByPasscodeAdapter())
      val typedAdapters = MoshiJsonConverter.getTangemSdkTypedAdapters()
      return MoshiJsonConverter(adapters, typedAdapters)
    }
  }

  sealed class FileCommand {
    data class Read(val readPrivateFiles: Boolean = false, val indices: List<Int>? = null)
    data class Write(val files: List<DataToWrite>)
    data class Delete(val indices: List<Int>?)
    data class ChangeSettings(val changes: List<FileSettingsChange>)
  }
}

class MoshiAdapters {

  class DataToWriteAdapter {
    @ToJson
    fun toJson(src: DataToWrite): String {
      return when (src) {
        is FileDataProtectedBySignature -> DataProtectedBySignatureAdapter().toJson(src)
        is FileDataProtectedByPasscode -> DataProtectedByPasscodeAdapter().toJson(src)
        else -> throw UnsupportedOperationException()
      }
    }

    @FromJson
    fun fromJson(map: MutableMap<String, Any>): DataToWrite {
      return if (map.containsKey("signature")) {
        DataProtectedBySignatureAdapter().fromJson(map)
      } else {
        DataProtectedByPasscodeAdapter().fromJson(map)
      }
    }
  }

  class DataProtectedBySignatureAdapter {
    @ToJson
    fun toJson(src: FileDataProtectedBySignature): String = MoshiJsonConverter.default().toJson(src)

    @FromJson
    fun fromJson(map: MutableMap<String, Any>): FileDataProtectedBySignature {
      val converter = MoshiJsonConverter.default()
      return converter.fromJson(converter.toJson(map)) !!
    }
  }

  class DataProtectedByPasscodeAdapter {
    @ToJson
    fun toJson(src: FileDataProtectedByPasscode): String = MoshiJsonConverter.default().toJson(src)

    @FromJson
    fun fromJson(map: MutableMap<String, Any>): FileDataProtectedByPasscode {
      val converter = MoshiJsonConverter.default()
      return converter.fromJson(converter.toJson(map)) !!
    }
  }
}

data class PluginError(
    // code = 1000 - it's the plugin or it's the tangemSdk internal exception
    // any other value in code greater than 10000 - it's the tangemSdk internal error
    val code: Int,
    val localizedDescription: String
)

class PluginException(
    message: String, cause: Throwable? = null
): Exception("TangemSdkPlugin exception. Message: $message", cause)

class TangemSdkException(cause: Throwable): Exception("TangemSdk internal exception", cause)

class CustomTangemSdkError(
    override var customMessage: String,
    override val code: Int = 5555555,
    override val messageResId: Int? = null
): TangemError