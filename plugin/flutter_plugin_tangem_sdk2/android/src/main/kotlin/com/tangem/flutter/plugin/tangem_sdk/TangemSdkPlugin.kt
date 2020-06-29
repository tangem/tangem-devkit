package com.tangem.flutter.plugin.tangem_sdk

import android.app.Activity
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import androidx.lifecycle.Lifecycle
import com.google.gson.Gson
import com.google.gson.JsonSyntaxException
import com.google.gson.reflect.TypeToken
import com.tangem.*
import com.tangem.commands.WriteIssuerExtraDataCommand
import com.tangem.commands.common.ResponseConverter
import com.tangem.commands.personalization.entities.*
import com.tangem.common.CompletionResult
import com.tangem.common.extensions.CardType
import com.tangem.common.extensions.hexToBytes
import com.tangem.common.extensions.toByteArray
import com.tangem.crypto.CryptoUtils
import com.tangem.crypto.sign
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
public class TangemSdkPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {

  private val handler = Handler(Looper.getMainLooper())
  private val converter = ResponseConverter()
  private lateinit var sdk: TangemSdk
  private var replyAlreadySubmit = false;

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

    sdk = TangemSdk(nfcManager.reader, cardManagerDelegate, Config(cardFilter = CardFilter(EnumSet.of(CardType.Sdk))))
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
    replyAlreadySubmit = false
    when (call.method) {
      "scanCard" -> scanCard(call, result)
      "sign" -> sign(call, result)
      "personalize" -> personalize(call, result)
      "depersonalize" -> depersonalize(call, result)
      "createWallet" -> createWallet(call, result)
      "purgeWallet" -> purgeWallet(call, result)
      "readIssuerData" -> readIssuerData(call, result)
      "writeIssuerData" -> writeIssuerData(call, result)
      "readIssuerExData" -> readIssuerExData(call, result)
      "writeIssuerExData" -> writeIssuerExData(call, result)
      "readUserData" -> readUserData(call, result)
      "writeUserData" -> writeUserData(call, result)
      "writeUserProtectedData" -> writeUserProtectedData(call, result)
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
      val issuer = extractPersonalizeObject("issuer", call, Issuer::class.java)
      val manufacturer = extractPersonalizeObject("manufacturer", call, Manufacturer::class.java)
      val acquirer = extractPersonalizeObject("acquirer", call, Acquirer::class.java)

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

  private fun readIssuerData(call: MethodCall, result: Result) {
    try {
      sdk.readIssuerData(cid(call), message(call)) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun writeIssuerData(call: MethodCall, result: Result) {
    try {
      val cardId = cid(call) !!
      val issuerData = issuerData(call)
      val counter = issuerDataCounter(call)
      val issuerPrivateKey = issuerPrivateKey(call)
      val dataSignature = issuerDataSignature(cardId, issuerData, counter, issuerPrivateKey)

      sdk.writeIssuerData(
          cardId,
          issuerData,
          dataSignature,
          counter,
          message(call)) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun readIssuerExData(call: MethodCall, result: Result) {
    try {
      sdk.readIssuerExtraData(cid(call)) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun writeIssuerExData(call: MethodCall, result: Result) {
    try {
      // from app
      val cardId = cid(call) !!
      val dataCounter = issuerDataCounter(call) ?: 1
      val hexCardId = cardId.hexToBytes()

      val counter = dataCounter.toByteArray(4)
      val issuerPrivateKey = issuerPrivateKey(call)
      val issuerData = CryptoUtils.generateRandomBytes(WriteIssuerExtraDataCommand.SINGLE_WRITE_SIZE * 5)
      val startingSignature = (hexCardId + counter + issuerData.size.toByteArray(2)).sign(issuerPrivateKey)
      val finalizingSignature = (hexCardId + issuerData + counter).sign(issuerPrivateKey)

      sdk.writeIssuerExtraData(
          cardId,
          issuerData,
          startingSignature,
          finalizingSignature,
          dataCounter,
          message(call)) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun readUserData(call: MethodCall, result: Result) {
    try {
      sdk.readUserData(cid(call), message(call)) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun writeUserData(call: MethodCall, result: Result) {
    try {
      sdk.writeUserData(cid(call), userData(call), userCounter(call), message(call)) { handleResult(result, it) }
    } catch (ex: Exception) {
      handleException(result, ex)
    }
  }

  private fun writeUserProtectedData(call: MethodCall, result: Result) {
    try {
      sdk.writeProtectedUserData(cid(call), userProtectedData(call), userProtectedCounter(call), message(call)) {
        handleResult(result, it)
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
    if (replyAlreadySubmit) return
    replyAlreadySubmit = true

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
      val name = "hashes"
      assert(call, name)

      val javaList = call.argument(name) as? ArrayList<String>?
      if (javaList == null || javaList.isEmpty()) throw NoSuchFieldException(name)

      return javaList.map { it.hexToBytes() }.toTypedArray()
    }

    @Throws(Exception::class)
    fun issuerData(call: MethodCall): ByteArray {
      return nullSafeFetchHexStringAndConvertToBytes(call, "issuerData")
    }

    @Throws(Exception::class)
    fun issuerDataSignature(cardId: String, issuerData: ByteArray, counter: Int?, issuerPrivateKey: ByteArray): ByteArray {
      var mergedData = cardId.hexToBytes() + issuerData
      counter?.let { mergedData += it.toByteArray(4) }
      return mergedData.sign(issuerPrivateKey)
    }

    @Throws(Exception::class)
    fun issuerDataCounter(call: MethodCall): Int? {
      if (! call.hasArgument("issuerDataCounter")) return null

      return call.argument<Int>("issuerDataCounter")
    }

    @Throws(Exception::class)
    fun issuerPrivateKey(call: MethodCall): ByteArray {
      return nullSafeFetchHexStringAndConvertToBytes(call, "issuerPrivateKey")
    }

    fun userData(call: MethodCall): ByteArray? {
      return fetchHexStringAndConvertToBytes(call, "userData")
    }

    fun userCounter(call: MethodCall): Int? {
      return call.argument<Int>("userCounter")
    }

    fun userProtectedData(call: MethodCall): ByteArray? {
      return fetchHexStringAndConvertToBytes(call, "userProtectedData")
    }

    fun userProtectedCounter(call: MethodCall): Int? {
      return call.argument<Int>("userProtectedCounter")
    }

    //    @Throws(Exception::class)
    //    fun startingSignature(jsO: JSONObject): ByteArray? {
    //      return fetchHexStringAndConvertToBytes(jsO, "startingSignature")
    //    }
    //
    //    @Throws(Exception::class)
    //    fun finalizingSignature(jsO: JSONObject): ByteArray? {
    //      return fetchHexStringAndConvertToBytes(jsO, "finalizingSignature")
    //    }

    @Throws(Exception::class)
    private fun nullSafeFetchHexStringAndConvertToBytes(call: MethodCall, name: String): ByteArray {
      assert(call, name)
      val hexString = call.argument<String>(name) !!
      return hexString.hexToBytes()
    }

    @Throws(Exception::class)
    private fun fetchHexStringAndConvertToBytes(call: MethodCall, name: String): ByteArray? {
      assert(call, name)
      val hexString = call.argument<String>(name)
      return hexString?.hexToBytes()
    }

    @Throws(Exception::class)
    private fun <T> extractObject(name: String, call: MethodCall, gson: Gson, type: Class<T>): T {
      if (! call.hasArgument(name)) throw NoSuchFieldException(name)

      val jsonString = call.argument<String>(name)
      return gson.fromJson(jsonString, type)
    }

    @Throws(Exception::class)
    private fun <T> extractPersonalizeObject(name: String, call: MethodCall, type: Class<T>): T {
      if (! call.hasArgument(name)) throw NoSuchFieldException(name)

      val gson = Gson()
      val mapType = object : TypeToken<MutableMap<String, Any?>>() {}.type
      val argMap: MutableMap<String, Any?> = gson.fromJson(call.argument<String>(name), mapType)
      val jsonString = when (name) {
        "issuer" -> {
          val dataKeyPair = gson.fromJson(argMap["dataKeyPair"].toString(), KeyPairHex::class.java)
          val transactionKeyPair = gson.fromJson(argMap["transactionKeyPair"].toString(), KeyPairHex::class.java)
          argMap["dataKeyPair"] = dataKeyPair.convert()
          argMap["transactionKeyPair"] = transactionKeyPair.convert()
          gson.toJson(argMap)
        }
        "manufacturer" -> {
          val keyPair = gson.fromJson(argMap["keyPair"].toString(), KeyPairHex::class.java)
          argMap["keyPair"] = keyPair.convert()
          gson.toJson(argMap)
        }
        "acquirer" -> {
          val keyPair = gson.fromJson(argMap["keyPair"].toString(), KeyPairHex::class.java)
          argMap["keyPair"] = keyPair.convert()
          gson.toJson(argMap)
        }
        else -> throw NoSuchFieldException(name)
      }
      return gson.fromJson(jsonString, type)
    }

    @Throws(Exception::class)
    private fun assert(call: MethodCall, name: String) {
      if (! call.hasArgument(name)) throw NoSuchFieldException(name)
    }
  }
}

data class PluginError(val code: Int, val localizedDescription: String)
data class KeyPairHex(val publicKey: String, val privateKey: String) {
  fun convert(): KeyPair = KeyPair(publicKey.hexToBytes(), privateKey.hexToBytes())
}