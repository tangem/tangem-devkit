package com.tangem.flutter.plugin.tangem_sdk

import android.app.Activity
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import com.squareup.moshi.FromJson
import com.squareup.moshi.ToJson
import com.squareup.sqldelight.android.AndroidSqliteDriver
import com.tangem.*
import com.tangem.commands.common.card.FirmwareType
import com.tangem.commands.common.jsonConverter.MoshiJsonConverter
import com.tangem.commands.file.FileData
import com.tangem.commands.file.FileSettingsChange
import com.tangem.common.CardValuesDbStorage
import com.tangem.common.CardValuesStorage
import com.tangem.common.CompletionResult
import com.tangem.common.extensions.hexToBytes
import com.tangem.tangem_sdk_new.DefaultSessionViewDelegate
import com.tangem.tangem_sdk_new.NfcLifecycleObserver
import com.tangem.tangem_sdk_new.TerminalKeysStorage
import com.tangem.tangem_sdk_new.extensions.localizedDescription
import com.tangem.tangem_sdk_new.nfc.NfcManager
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
  private var replyAlreadySubmit = false;

  override fun onAttachedToActivity(pluginBinding: ActivityPluginBinding) {
    val activity = pluginBinding.activity
    wActivity = WeakReference(activity)

    val nfcManager = createNfcManager(pluginBinding)
    sdk = TangemSdk(
        nfcManager.reader,
        createViewDelegate(activity, nfcManager),
        Config(cardFilter = CardFilter(EnumSet.of(FirmwareType.Sdk))),
        createValueStorage(activity),
        TerminalKeysStorage(activity.application)
    )
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

  private fun createValueStorage(activity: Activity): CardValuesStorage = CardValuesDbStorage(
      AndroidSqliteDriver(Database.Schema, activity.applicationContext, "flutter_cards.db")
  )

  override fun onDetachedFromActivity() {
  }

  override fun onReattachedToActivityForConfigChanges(pluginBinding: ActivityPluginBinding) {
    wActivity = WeakReference(pluginBinding.activity)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    wActivity = WeakReference(null)
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    val channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "tangemSdk")
    channel.setMethodCallHandler(this);
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    replyAlreadySubmit = false
    when (call.method) {
      "allowsOnlyDebugCards" -> allowsOnlyDebugCards(call, result)
      "scanCard" -> scanCard(call, result)
      "sign" -> sign(call, result)
      "personalize" -> personalize(call, result)
      "depersonalize" -> depersonalize(call, result)
      "readIssuerData" -> readIssuerData(call, result)
      "writeIssuerData" -> writeIssuerData(call, result)
      "readIssuerExData" -> readIssuerExtraData(call, result)
      "writeIssuerExData" -> writeIssuerExtraData(call, result)
      "readUserData" -> readUserData(call, result)
      "writeUserData" -> writeUserData(call, result)
      "writeUserProtectedData" -> writeUserProtectedData(call, result)
      "createWallet" -> createWallet(call, result)
      "purgeWallet" -> purgeWallet(call, result)
      "setPin1" -> setPin1(call, result)
      "setPin2" -> setPin2(call, result)
      "writeFiles" -> writeFiles(call, result)
      "readFiles" -> readFiles(call, result)
      "deleteFiles" -> deleteFiles(call, result)
      "changeFilesSettings" -> changeFilesSettings(call, result)
      "prepareHashes" -> prepareHashes(call, result)
      "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      else -> result.notImplemented()
    }
  }

  private fun scanCard(call: MethodCall, result: Result) {
    try {
      sdk.scanCard(
          call.extractOptional("initialMessage")
      ) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun sign(call: MethodCall, result: Result) {
    try {
      sdk.sign(
          call.extract("hashes") as Array<ByteArray>,
          call.extract("walletPublicKey"),
          call.extractOptional("cardId"),
          call.extractOptional("initialMessage")
      ) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun personalize(call: MethodCall, result: Result) {
    try {
      sdk.personalize(
          call.extract("cardConfig"),
          call.extract("issuer"),
          call.extract("manufacturer"),
          call.extract("acquirer"),
          call.extractOptional("initialMessage")
      ) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun depersonalize(call: MethodCall, result: Result) {
    try {
      sdk.depersonalize(
          call.extractOptional("initialMessage")
      ) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun createWallet(call: MethodCall, result: Result) {
    try {
      sdk.createWallet(
          call.extractOptional("config"),
          call.extractOptional("cardId"),
          call.extractOptional("initialMessage")
      ) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun purgeWallet(call: MethodCall, result: Result) {
    try {
      sdk.purgeWallet(
          call.extract("walletIndex"),
          call.extractOptional("cardId"),
          call.extractOptional("initialMessage")
      ) { handleResult(result, it) }
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
          call.extractOptional("cardId"),
          call.extract("userData"),
          call.extractOptional("userCounter"),
          call.extractOptional("initialMessage")
      ) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun setPin1(call: MethodCall, result: Result) {
    try {
      sdk.changePin1(
          call.extractOptional("cardId"),
          call.extractOptional("pin"),
          call.extractOptional("initialMessage")
      ) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun setPin2(call: MethodCall, result: Result) {
    try {
      sdk.changePin2(
          call.extractOptional("cardId"),
          call.extractOptional("pin"),
          call.extractOptional("initialMessage")
      ) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun writeUserProtectedData(call: MethodCall, result: Result) {
    try {
      sdk.writeUserProtectedData(
          call.extractOptional("cardId"),
          call.extract("userProtectedData"),
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
        EnumSet.of(FirmwareType.Sdk)
      } else {
        EnumSet.allOf(FirmwareType::class.java)
      }
      sdk.config.cardFilter.allowedCardTypes = allowedCardTypes
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

    handler.post {
      val code = 9999
      val localizedDescription: String = ex.toString()
      result.error("$code".capitalize(), localizedDescription,
          converter.toJson(PluginError(code, localizedDescription)))
    }
  }

  @Throws(Exception::class)
  inline fun <reified T> MethodCall.extract(name: String): T {
    return this.extractOptional(name) ?: throw NoSuchFieldException(name)
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
      val converter = MoshiJsonConverter(adapters)
      MoshiJsonConverter.setInstance(converter)
      return converter
    }
  }

  sealed class FileCommand {
    data class Read(val readPrivateFiles: Boolean = false, val indices: List<Int>? = null)
    data class Write(val files: List<FileData>)
    data class Delete(val indices: List<Int>?)
    data class ChangeSettings(val changes: List<FileSettingsChange>)
  }
}

class MoshiAdapters {

  class DataToWriteAdapter {
    @ToJson
    fun toJson(src: FileData): String {
      return when (src) {
        is FileData.DataProtectedBySignature -> DataProtectedBySignatureAdapter().toJson(src)
        is FileData.DataProtectedByPasscode -> DataProtectedByPasscodeAdapter().toJson(src)
      }
    }

    @FromJson
    fun fromJson(map: MutableMap<String, Any>): FileData {
      return if (map.containsKey("signature")) {
        DataProtectedBySignatureAdapter().fromJson(map)
      } else {
        DataProtectedByPasscodeAdapter().fromJson(map)
      }
    }
  }

  class DataProtectedBySignatureAdapter {
    @ToJson
    fun toJson(src: FileData.DataProtectedBySignature): String = MoshiJsonConverter.default().toJson(src)

    @FromJson
    fun fromJson(map: MutableMap<String, Any>): FileData.DataProtectedBySignature {
      val converter = MoshiJsonConverter.default()
      return converter.fromJson(converter.toJson(map)) !!
    }
  }

  class DataProtectedByPasscodeAdapter {
    @ToJson
    fun toJson(src: FileData.DataProtectedByPasscode): String = MoshiJsonConverter.default().toJson(src)

    @FromJson
    fun fromJson(map: MutableMap<String, Any>): FileData.DataProtectedByPasscode {
      val converter = MoshiJsonConverter.default()
      return converter.fromJson(converter.toJson(map)) !!
    }
  }
}

data class PluginError(val code: Int, val localizedDescription: String)