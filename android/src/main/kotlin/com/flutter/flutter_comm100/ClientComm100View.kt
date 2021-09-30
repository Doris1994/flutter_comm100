package com.flutter.flutter_comm100

import android.app.Activity
import android.content.Intent
import android.view.View
import android.webkit.CookieManager
import com.comm100.livechat.VisitorClientInterface
import com.comm100.livechat.core.VisitorClientCore
import com.comm100.livechat.view.ChatWindowWebView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView

class ClientComm100View(
    activity: Activity,
    messenger: BinaryMessenger,
    viewId: Int,
    args: Map<String, Any>?
) : PlatformView {
    private val mChatWindow: ChatWindowWebView by lazy { ChatWindowWebView(activity) }

    init {
        args?.let {
            var url = it["url"] as String?
            VisitorClientInterface.setChatUrl(url)
            mChatWindow.loadUrl(VisitorClientCore.getInstance().chatUrl)
            CookieManager.getInstance().setAcceptCookie(true)
        }
    }

    override fun getView(): View {
        return mChatWindow
    }

    override fun dispose() {
        mChatWindow.destroy()
    }

    fun activityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        mChatWindow.onActivityResult(requestCode, resultCode, data)
        return false
    }

}