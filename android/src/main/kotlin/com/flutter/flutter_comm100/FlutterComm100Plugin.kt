package com.flutter.flutter_comm100

import android.app.Activity
import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry


/** FlutterComm100Plugin */
class FlutterComm100Plugin: FlutterPlugin, MethodCallHandler , ActivityAware ,PluginRegistry.ActivityResultListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var mActivity: Activity
  private lateinit var mFlutterPluginBinding: FlutterPlugin.FlutterPluginBinding
  private  lateinit var factory:ClientComm100ViewFactory

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutter_comm100")
    channel.setMethodCallHandler(this)

    mFlutterPluginBinding = flutterPluginBinding
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }
  }
  companion object {
    @JvmStatic
    fun registerWith(registrar: PluginRegistry.Registrar) {
      val channel = MethodChannel(registrar.messenger(), "flutter_comm100")
      channel.setMethodCallHandler(FlutterComm100Plugin())

      registrar
        .platformViewRegistry()
        .registerViewFactory(
          "plugins.flutter.io/comm100_view",
          ClientComm100ViewFactory(registrar.messenger(),registrar.activity()))
    }
  }
  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    mActivity = binding.activity
    binding.addActivityResultListener(this)
    val messenger: BinaryMessenger = mFlutterPluginBinding.binaryMessenger
    factory =  ClientComm100ViewFactory(messenger,mActivity)
    mFlutterPluginBinding
      .platformViewRegistry
      .registerViewFactory(
        "plugins.flutter.io/comm100_view", factory)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    TODO("Not yet implemented")
  }

  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
    return if (factory != null && factory.getFlutterWebView() != null) {
      factory.getFlutterWebView()!!.activityResult(requestCode, resultCode, data)
    } else false
  }


}
