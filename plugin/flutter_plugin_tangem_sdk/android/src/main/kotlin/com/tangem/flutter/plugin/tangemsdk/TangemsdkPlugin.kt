package com.tangem.flutter.plugin.tangemsdk

import androidx.annotation.NonNull
import androidx.lifecycle.Lifecycle
import com.tangem.Config
import com.tangem.TangemSdk
import com.tangem.tangem_sdk_new.DefaultSessionViewDelegate
import com.tangem.tangem_sdk_new.NfcLifecycleObserver
import com.tangem.tangem_sdk_new.TerminalKeysStorage
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

/** TangemsdkPlugin */
public class TangemsdkPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var sdk: TangemSdk

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    val channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "tangemSdk")
    channel.setMethodCallHandler(this);
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "scanCard" -> scanCard(result)
      "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      else -> result.notImplemented()
    }
  }

  private fun scanCard(result: Result) {

    try {
      sdk.scanCard(null) {
        result.success("card scanned")
      }
    } catch (ex: Exception) {
      result.error("Scan card error", ex.toString(), ex)
    }
  }

  override fun onAttachedToActivity(pluginBinding: ActivityPluginBinding) {
    init(pluginBinding)
  }


  override fun onDetachedFromActivity() {
  }

  override fun onReattachedToActivityForConfigChanges(pluginBinding: ActivityPluginBinding) {
  }

  override fun onDetachedFromActivityForConfigChanges() {
  }

  fun init(pluginBinding: ActivityPluginBinding) {
    //    this.converter = createConverter()

    val activity = pluginBinding.activity
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

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "sdk")
      channel.setMethodCallHandler(TangemsdkPlugin())
    }
  }
}
