//
//  FLNativeView.swift
//  Runner
//
//  Created by BacBon Limited on 25/7/22.
//

import Foundation
import Flutter
import UIKit
import SwiftUI
import WebKit

public class SwiftEmbeddedYoutubePlayerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
      let factory = YouTubePlayerViewFactory(messenger: registrar.messenger())
      registrar.register(factory, withId: "com.codepoka.embedded_youtube_player")
  }
}


class YouTubePlayerViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return YouTubePlayerView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
    
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
}

class YouTubePlayerView: NSObject, FlutterPlatformView {
    var _args : Any?
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        super.init()
        self._args = args
    }

    func view() -> UIView {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        let webView =  WKWebView(frame: CGRect(x: 0, y: 0, width: 375, height: 300), configuration: webConfiguration)
        
        guard let _args = _args as? [String: Any], let _id = _args["video_id"] as? String else {
            return webView
        }
                
        webView.load(URLRequest(url: URL.init(string:"https://www.youtube.com/embed/\(_id)?autoplay=1&showinfo=0&loop=0&rel=0&enablejsapi=1&modestbranding=1")!))

        return webView
    }
}
