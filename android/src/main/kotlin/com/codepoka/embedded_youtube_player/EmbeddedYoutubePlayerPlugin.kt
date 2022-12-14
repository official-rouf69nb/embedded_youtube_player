package com.codepoka.embedded_youtube_player

import android.app.Activity
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin

import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
//import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** EmbeddedYoutubePlayerPlugin */
class EmbeddedYoutubePlayerPlugin: FlutterPlugin, ActivityAware {
  private lateinit var pluginBinding: FlutterPlugin.FlutterPluginBinding
  private lateinit var activity: Activity

  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
//  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
//    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "embedded_youtube_player")
//    channel.setMethodCallHandler(this)
//
    pluginBinding = flutterPluginBinding
  }

//  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
////    if (call.method == "getPlatformVersion") {
////      result.success("Android ${android.os.Build.VERSION.RELEASE}")
////    } else {
////      result.notImplemented()
////    }
//  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
//    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    pluginBinding.platformViewRegistry
      .registerViewFactory("com.codepoka.embedded_youtube_player", YouTubePlayerViewFactory(binding.activity))
  }

  override fun onDetachedFromActivityForConfigChanges() {}

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {}
}
