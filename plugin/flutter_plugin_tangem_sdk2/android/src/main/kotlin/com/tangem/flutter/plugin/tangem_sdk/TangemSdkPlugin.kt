package com.tangem.flutter.plugin.tangem_sdk

import android.app.Activity
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import androidx.lifecycle.Lifecycle
import com.google.gson.Gson
import com.google.gson.JsonSyntaxException
import com.tangem.Config
import com.tangem.Message
import com.tangem.TangemSdk
import com.tangem.commands.common.ResponseConverter
import com.tangem.commands.personalization.entities.*
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

/** TangemSdkPlugin */
public class TangemSdkPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {

  private val handler = Handler(Looper.getMainLooper())
  private val converter = ResponseConverter()
  private lateinit var sdk: TangemSdk
  private var replyАlreadySubmitte = false;

  override fun onAttachedToActivity(pluginBinding: ActivityPluginBinding) {
    val activity = pluginBinding.activity
    wActivity = WeakReference(activity)
    val hiddenLifecycleReference: HiddenLifecycleReference = pluginBinding.lifecycle as HiddenLifecycleReference

    val nfcManager = NfcManager()
    nfcManager.setCurrentActivity(activity)
    val lifecycle: Lifecycle = hiddenLifecycleReference.getLifecycle() as Lifecycle
    lifecycle.addObserver(NfcLifecycleObserver(nfcManager))

    val cardManagerDelegate = DefaultSessionViewDelegate(nfcManager.reader)
    cardManagerDelegate.activity = activity

    sdk = TangemSdk(nfcManager.reader, cardManagerDelegate, Config())
    sdk.setTerminalKeysService(TerminalKeysStorage(activity.application))
  }

  override fun onDetachedFromActivity() {
  }

  override fun onReattachedToActivityForConfigChanges(pluginBinding: ActivityPluginBinding) {
  }

  override fun onDetachedFromActivityForConfigChanges() {
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    val channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "tangemSdk")
    channel.setMethodCallHandler(this);
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    replyАlreadySubmitte = false
    when (call.method) {
      "scanCard" -> scanCard(call, result)
      "sign" -> sign(call, result)
      "personalize" -> personalize(call, result)
      "depersonalize" -> depersonalize(call, result)
      "createWallet" -> createWallet(call, result)
      "purgeWallet" -> purgeWallet(call, result)
      "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      else -> result.notImplemented()
    }
  }

  private fun scanCard(call: MethodCall, result: Result) {
    try {
      sdk.scanCard(message(call)) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun sign(call: MethodCall, result: Result) {
    try {
      sdk.sign(hashes(call), cid(call), message(call)) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun personalize(call: MethodCall, result: Result) {
    try {
      val cardConfig = extractCardConfig(call);
      val issuer = extractObject("issuer", call, converter.gson, Issuer::class.java)
      val manufacturer = extractObject("manufacturer", call, converter.gson, Manufacturer::class.java)
      val acquirer = extractObject("acquirer", call, converter.gson, Acquirer::class.java)
      sdk.personalize(cardConfig, issuer, manufacturer, acquirer, message(call)) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun extractCardConfig(call: MethodCall): CardConfig {
    val broken = extractObject("cardConfig", call, converter.gson, CardConfig::class.java)
    val repairedNdefRecords = mutableListOf<NdefRecord>()
    broken.ndefRecords.forEach { repairedNdefRecords.add(NdefRecord(it.type, it.value)) }
    val config = CardConfig(
        broken.issuerName, broken.acquirerName, broken.series, broken.startNumber, broken.count, broken.pin, broken.pin2,
        broken.pin3, broken.hexCrExKey, broken.cvc, broken.pauseBeforePin2, broken.smartSecurityDelay, broken.curveID,
        broken.signingMethods, broken.maxSignatures, broken.isReusable, broken.allowSwapPin, broken.allowSwapPin2,
        broken.useActivation, broken.useCvc, broken.useNdef, broken.useDynamicNdef, broken.useOneCommandAtTime, broken
        .useBlock, broken.allowSelectBlockchain, broken.forbidPurgeWallet, broken.protocolAllowUnencrypted,
        broken.protocolAllowStaticEncryption, broken.protectIssuerDataAgainstReplay, broken.forbidDefaultPin,
        broken.disablePrecomputedNdef, broken.skipSecurityDelayIfValidatedByIssuer,
        broken.skipCheckPIN2andCVCIfValidatedByIssuer, broken.skipSecurityDelayIfValidatedByLinkedTerminal,
        broken.restrictOverwriteIssuerDataEx, broken.requireTerminalTxSignature, broken.requireTerminalCertSignature,
        broken.checkPin3onCard, broken.createWallet, broken.cardData, repairedNdefRecords)
    return config
  }

  private fun depersonalize(call: MethodCall, result: Result) {
    try {
      sdk.depersonalize(cid(call), message(call)) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun createWallet(call: MethodCall, result: Result) {
    try {
      sdk.createWallet(cid(call), message(call)) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun purgeWallet(call: MethodCall, result: Result) {
    try {
      sdk.purgeWallet(cid(call), message(call)) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun handleResult(result: Result, completionResult: CompletionResult<*>) {
    if (replyАlreadySubmitte) return
    replyАlreadySubmitte = true

    when (completionResult) {
      is CompletionResult.Success -> {
        handler.post { result.success(converter.gson.toJson(completionResult.data)) }
      }
      is CompletionResult.Failure -> {
        val error = completionResult.error
        val localizedDescription = wActivity.get()?.getString(error.localizedDescription()) ?: error.code.toString()
        val pluginError = PluginError(error.code, localizedDescription)
        handler.post {
          result.error("${error.code}", localizedDescription, converter.gson.toJson(pluginError))
        }
      }
    }
  }

  private fun handleException(result: Result, ex: Exception) {
    if (replyАlreadySubmitte) return
    replyАlreadySubmitte = true

    handler.post {
      val code = 9999
      val localizedDescription: String = if (ex is JsonSyntaxException) {
        ex.cause.toString()
      } else {
        ex.localizedMessage ?: ex.message ?: ex.toString()
      }
      result.error("$code", localizedDescription, converter.gson.toJson(PluginError(code, localizedDescription)))
    }
  }

  companion object {
    // Companion methods must be of two types:
    // for optional request => return if (fieldIsFound) foundField else null
    // for required parameters request => return if (fieldIsFound) foundField else throw NoSuchFieldException
    // All exceptions must be handled by an external representative.
    lateinit var wActivity: WeakReference<Activity>

    @Throws(Exception::class)
    fun message(call: MethodCall): Message? {
      if (! call.hasArgument("initialMessage")) return null

      val objMessage = call.argument<Any>("initialMessage")
      if (objMessage == null || objMessage !is Map<*, *>) return null

      val mapMessage = objMessage.map { (key, value) -> key.toString() to value.toString() }.toMap<String, String>()
      val header = mapMessage["header"] ?: ""
      val body = mapMessage["body"] ?: ""
      return Message(header, body)
    }

    @Throws(Exception::class)
    fun cid(call: MethodCall): String? {
      return call.argument<String>("cid")
    }

    @Throws(Exception::class)
    fun hashes(call: MethodCall): Array<ByteArray> {
      if (! call.hasArgument("hashes")) throw NoSuchFieldException("hashes")

      val javaList = call.argument("hashes") as? ArrayList<String>?
      if (javaList == null || javaList.isEmpty()) throw NoSuchFieldException("hashes")

      return javaList.map { it.hexToBytes() }.toTypedArray()
    }

    @Throws(Exception::class)
    private fun <T> extractObject(name: String, call: MethodCall, gson: Gson, type: Class<T>): T {
      if (! call.hasArgument(name)) throw NoSuchFieldException(name)

      val jsonString = call.argument<String>(name)
      return gson.fromJson(jsonString, type)
    }

    //    @Throws(Exception::class)
    //    fun issuerData(jsO: JSONObject): ByteArray? {
    //      return fetchHexStringAndConvertToBytes(jsO, "issuerData")
    //    }
    //
    //    @Throws(Exception::class)
    //    fun issuerDataSignatures(jsO: JSONObject): ByteArray? {
    //      return fetchHexStringAndConvertToBytes(jsO, "issuerDataSignature")
    //    }
    //
    //    @Throws(Exception::class)
    //    fun startingSignature(jsO: JSONObject): ByteArray? {
    //      return fetchHexStringAndConvertToBytes(jsO, "startingSignature")
    //    }
    //
    //    @Throws(Exception::class)
    //    fun finalizingSignature(jsO: JSONObject): ByteArray? {
    //      return fetchHexStringAndConvertToBytes(jsO, "finalizingSignature")
    //    }
    //
    //    @Throws(Exception::class)
    //    fun issuerDataCounter(jsO: JSONObject): Int? {
    //      return if (jsO.has("issuerDataCounter")) jsO.getInt("issuerDataCounter") else null
    //    }
    //
    //    @Throws(Exception::class)
    //    fun userData(jsO: JSONObject): ByteArray? {
    //      return fetchHexStringAndConvertToBytes(jsO, "userData")
    //    }
    //
    //    @Throws(Exception::class)
    //    fun userProtectedData(jsO: JSONObject): ByteArray? {
    //      return fetchHexStringAndConvertToBytes(jsO, "userProtectedData")
    //    }
    //
    //    @Throws(Exception::class)
    //    fun userCounter(jsO: JSONObject): Int? {
    //      return if (jsO.has("userCounter")) jsO.getInt("userCounter") else null
    //    }
    //
    //    @Throws(Exception::class)
    //    fun userProtectedCounter(jsO: JSONObject): Int? {
    //      return if (jsO.has("userProtectedCounter")) jsO.getInt("userProtectedCounter") else null
    //    }
    //
    //    @Throws(Exception::class)
    //    private fun fetchHexStringAndConvertToBytes(jsO: JSONObject, name: String): ByteArray? {
    //      val hexString = jsO.getString(name)
    //      return hexString.hexToBytes()
    //    }
    //  }
  }
}

data class PluginError(val code: Int, val localizedDescription: String)
