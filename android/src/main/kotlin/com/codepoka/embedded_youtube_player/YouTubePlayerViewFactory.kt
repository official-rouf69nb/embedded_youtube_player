@file:Suppress("UNCHECKED_CAST")

package com.codepoka.embedded_youtube_player


import android.app.Activity
import android.content.Context
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class YouTubePlayerViewFactory(private val mainActivity: Activity) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        return YouTubePlayerView(context!!, args as Map<String?, Any?>?, mainActivity)
    }
}