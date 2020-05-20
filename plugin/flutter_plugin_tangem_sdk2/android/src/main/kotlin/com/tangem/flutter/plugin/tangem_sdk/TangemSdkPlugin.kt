package com.tangem.flutter.plugin.tangem_sdk

import android.app.Activity
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import androidx.lifecycle.Lifecycle
import com.tangem.Config
import com.tangem.Message
import com.tangem.TangemSdk
import com.tangem.common.CompletionResult
import com.tangem.common.extensions.hexToBytes
import com.tangem.tangem_sdk_new.DefaultSessionViewDelegate
import com.tangem.tangem_sdk_new.NfcLifecycleObserver
import com.tangem.tangem_sdk_new.TerminalKeysStorage
import com.tangem.tangem_sdk_new.converter.ResponseConverter
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
import io.flutter.plugin.common.PluginRegistry.Registrar
import org.json.JSONObject
import java.lang.ref.WeakReference

/** TangemSdkPlugin */
public class TangemSdkPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {

  private val handler = Handler(Looper.getMainLooper())
  private val converter = ResponseConverter()
  private lateinit var sdk: TangemSdk

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
    when (call.method) {
      "scanCard" -> scanCard(call, result)
      "sign" -> sign(call, result)
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

  private fun handleResult(result: Result, completionResult: CompletionResult<*>) {
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
    handler.post {
      val code = 9999
      val localizedDescription = ex.localizedMessage ?: ex.message ?: ex.toString()
      result.error("$code", localizedDescription, PluginError(code, localizedDescription))
    }
  }

  companion object {
    lateinit var wActivity: WeakReference<Activity>

    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "sdk")
      channel.setMethodCallHandler(TangemSdkPlugin())
    }

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
    fun cid(call: MethodCall): String {
      return call.argument<String>("cid") !!
    }

    @Throws(Exception::class)
    fun hashes(call: MethodCall): Array<ByteArray> {
      if (! call.hasArgument("hashes")) throw NoSuchFieldException("hashes")

      val javaList = call.argument("hashes") as? ArrayList<String>?
      if (javaList == null || javaList.isEmpty()) throw NoSuchFieldException("hashes")

      return javaList.map { it.hexToBytes() }.toTypedArray()
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

data class PluginError(val code: Int, val localizedDescription: String)
