//
//  File.swift
//
//
//  Created by Mustafa Karakus on 14.06.2024.
//

import SwiftUI
import WebKit

@Observable
public class WebViewViewModel {
    var webResource: String?
    var webView: WKWebView
    var messageFromWV: String = ""
    var isLoading: Bool = false
    
    public init(webResource: String? = nil) {
        self.webResource = webResource
        let configuration = WKWebViewConfiguration()
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        configuration.defaultWebpagePreferences = preferences
        self.webView = WKWebView(frame: .zero,
                                 configuration: configuration)
        self.webView.isOpaque = false
        self.webView.backgroundColor = UIColor.clear
#if DEBUG
        self.webView.isInspectable = true
#endif
    }
    
    func messageTo(message: String) {
        let escapedMessage = message.replacingOccurrences(of: "\"", with: "\\\"")
        
        let js = "window.postMessage(\"\(escapedMessage)\", \"*\")"
        self.webView.evaluateJavaScript(js) { (result, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func messageFrom(message: Any) {
        self.messageFromWV = String(describing: message)
        print("messageFromWV \(self.messageFromWV)")
    }
    
    func messageFromWithReply(fromHandler: String, message: Any) throws -> String {
        self.messageFromWV = String(describing: message)
        return messageFromWV
    }
    
    public func loadWebPage() {
        if let webResource = webResource {
            guard let url = URL(string: webResource) else {
                print("Bad URL")
                return
            }
            
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
