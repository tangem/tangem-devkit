package com.tangem.flutter.plugin.tangem_sdk

import android.os.Handler
import com.google.gson.Gson
import com.tangem.*
import com.tangem.commands.PinType
import io.flutter.plugin.common.MethodChannel

/**
 * Created by Anton Zhilenkov on 22/03/2021.
 */
class PluginViewDelegate(
    private val channel: MethodChannel,
    private val handler: Handler,
    private val gson: Gson
): SessionViewDelegate {

  override fun dismiss() {
    invokeMethod("dismiss")
  }

  override fun onDelay(total: Int, current: Int, step: Int) {
    invokeMethod("onDelay", convertToString(OnDelay(total, current, step)))
  }

  override fun onError(error: TangemError) {
    invokeMethod("onError", convertToString(error))
  }

  override fun onPinChangeRequested(pinType: PinType, callback: (pin: String) -> Unit) {
    //TODO: how to handle callback ???
    invokeMethod("onPinChangeRequested", convertToString(pinType))
  }

  override fun onPinRequested(pinType: PinType, isFirstAttempt: Boolean, callback: (pin: String) -> Unit) {
    //TODO: how to handle callback ???
    invokeMethod("onPinRequested", convertToString(OnPinRequested(pinType, isFirstAttempt)))
  }

  override fun onSecurityDelay(ms: Int, totalDurationSeconds: Int) {
    invokeMethod("onSecurityDelay", convertToString(OnSecurityDelay(ms, totalDurationSeconds)))
  }

  override fun onSessionStarted(cardId: String?, message: Message?, enableHowTo: Boolean) {
    invokeMethod("onSessionStarted", convertToString(OnSessionStarted(cardId, message, enableHowTo)))
  }

  override fun onSessionStopped(message: Message?) {
    invokeMethod("onSessionStopped", convertToString(message))
  }

  override fun onTagConnected() {
    invokeMethod("onTagConnected")
  }

  override fun onTagLost() {
    invokeMethod("onTagLost")
  }

  override fun onWrongCard(wrongValueType: WrongValueType) {
    invokeMethod("onWrongCard", convertToString(wrongValueType))
  }

  override fun setConfig(config: Config) {
    //    invokeMethod("setConfig", convertToString(config))
  }

  override fun setMessage(message: Message?) {
    invokeMethod("setMessage", convertToString(message))
  }

  private fun invokeMethod(name: String, args: String? = null) {
    handler.post { channel.invokeMethod(name, args) }
  }

  private fun convertToString(obj: Any?): String? {
    if (obj == null) return null

    return gson.toJson(obj)
  }

  internal data class OnDelay(val total: Int, val current: Int, val step: Int)
  internal data class OnPinRequested(val pinType: PinType, val isFirstAttempt: Boolean)
  internal data class OnSecurityDelay(val ms: Int, val totalDurationSeconds: Int)
  internal data class OnSessionStarted(val cardId: String?, val message: Message?, val enableHowTo: Boolean)
}