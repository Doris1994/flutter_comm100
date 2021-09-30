package com.flutter.flutter_comm100

import android.app.Activity
import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class ClientComm100ViewFactory(
    private val messenger: BinaryMessenger,
    private val activity: Activity
) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    private lateinit var flutterWebView: ClientComm100View

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        flutterWebView = ClientComm100View(activity, messenger, viewId, args as Map<String, Any>?)
        return flutterWebView
    }

    fun getFlutterWebView(): ClientComm100View {
        return flutterWebView
    }
}