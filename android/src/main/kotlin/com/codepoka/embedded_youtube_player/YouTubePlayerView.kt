package com.codepoka.embedded_youtube_player


import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.content.pm.ActivityInfo
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Build
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.Window
import android.webkit.WebChromeClient
import android.webkit.WebSettings
import android.webkit.WebView
import android.widget.RelativeLayout
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat
import io.flutter.plugin.platform.PlatformView
import java.lang.ref.WeakReference


@SuppressLint("SetJavaScriptEnabled", "InflateParams")
internal class YouTubePlayerView(
    context: Context,
    creationParams: Map<String?, Any?>?,
    mainActivity: Activity
) : PlatformView {
    private val nativeView: RelativeLayout

    override fun getView(): View {
        return nativeView
    }

    override fun dispose() {}

    init {

        val li =  LayoutInflater.from(context)
        nativeView = li.inflate(R.layout.youtube_player_view,null) as RelativeLayout
        val webView = nativeView.findViewById(R.id.webView) as WebView
        webView.settings.javaScriptEnabled = true
        webView.settings.loadsImagesAutomatically = true
        webView.settings.javaScriptCanOpenWindowsAutomatically = true
        webView.loadUrl("https://www.youtube.com/embed/${creationParams?.get("video_id")}?autoplay=1&mute=1&enablejsapi=1&showinfo=0&loop=0&rel=0")

        webView.webChromeClient = WebChrome(mainActivity)
    }


}

class WebChrome(private  val activity: Activity) : WebChromeClient() {

    private val activityRef = WeakReference(activity)

    private var customView: View? = null
    private var customViewCallback: CustomViewCallback? = null

    override fun getDefaultVideoPoster(): Bitmap? {
        return activityRef.get()?.run {
            BitmapFactory.decodeResource(applicationContext.resources, 2130837573)
        }
    }

    @SuppressLint("SourceLockedOrientationActivity")
    override fun onHideCustomView() {
        activityRef.get()?.run {
            (window.decorView as ViewGroup).removeView(customView)
            customView = null

            val window: Window = activity.window
            val decorView: View = activity.window.decorView

            WindowCompat.setDecorFitsSystemWindows(window, false)
            val controllerCompat = WindowInsetsControllerCompat(window, decorView)
            controllerCompat.show(WindowInsetsCompat.Type.systemBars() or WindowInsetsCompat.Type.navigationBars())
            controllerCompat.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE

            requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_PORTRAIT
        }
        customViewCallback?.onCustomViewHidden()
        customViewCallback = null
    }

    override fun onShowCustomView(view: View?, viewCallback: CustomViewCallback?) {
        if (customView != null) {
            onHideCustomView()
            return
        }
        customView = view
        activityRef.get()?.run {
            //hide system UI
            val window: Window = activity.window
            val decorView: View = activity.window.decorView

            WindowCompat.setDecorFitsSystemWindows(window, false)
            val controllerCompat = WindowInsetsControllerCompat(window, decorView)
            controllerCompat.hide(WindowInsetsCompat.Type.systemBars() or WindowInsetsCompat.Type.navigationBars())
            controllerCompat.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE

            requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE

            customViewCallback = viewCallback
            (window.decorView as ViewGroup).addView(
                customView,
                ViewGroup.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.MATCH_PARENT
                )
            )
        }
    }
}