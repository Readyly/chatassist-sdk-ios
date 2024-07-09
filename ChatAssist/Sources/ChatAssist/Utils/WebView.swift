//
//  WebView.swift
//
//
//  Created by Mustafa Karakus on 12.06.2024.
//

import SwiftUI
import WebKit

let messageHandlerKey = "ftMessageHandler"

struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    var viewModel: WebViewViewModel
    
    func makeUIView(context: Context) -> WKWebView {
        let userContentController = viewModel.webView
            .configuration
            .userContentController
        
        userContentController.removeAllScriptMessageHandlers()
        userContentController.add(context.coordinator, contentWorld: WKContentWorld.page, name: messageHandlerKey)
        viewModel.webView.uiDelegate = context.coordinator
        viewModel.webView.navigationDelegate = context.coordinator
        viewModel.webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        viewModel.webView.evaluateJavaScript("navigator.userAgent") {(result, error) in
            DispatchQueue.main.async {
                if let userAgent = result as? String {
                    viewModel.webView.customUserAgent = userAgent + " WebView_Widget_iOS/2.0.7"
                }
            }
        }
        viewModel.loadWebPage()
        return viewModel.webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(viewModel: viewModel)
    }
}

extension WebView {
    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler, WKScriptMessageHandlerWithReply {
        var viewModel: WebViewViewModel
        
        init(viewModel: WebViewViewModel) {
            self.viewModel = viewModel
        }
        
        func userContentController(_ userContentController: WKUserContentController,
                                   didReceive message: WKScriptMessage) {
            if message.name == messageHandlerKey {
                handleMessage(jsonString: String(describing: message.body))
            }
        }
        
        private func handleMessage(jsonString: String) {
            guard let data = jsonString.data(using: .utf8) else {
                print("Failed to convert string to data")
                return
            }
            
            do {
                let payload = try JSONDecoder().decode(Chat.MessagePayload.self, from: data)
                if let action = Chat.Action(rawValue: payload.type) {
                    viewModel.receivedAction(action)
                }
            } catch {
                print("Failed to read message: \(error)")
            }
        }
        
        
        func userContentController(_ userContentController: WKUserContentController,
                                   didReceive message: WKScriptMessage,
                                   replyHandler: @escaping (Any?, String?) -> Void) {
            do {
                let returnValue = try self.viewModel.messageFromWithReply(fromHandler: message.name,
                                                                          message: message.body)
                
                replyHandler(returnValue, nil)
            } catch WebViewErrors.GenericError {
                replyHandler(nil, "A generic error")
            } catch WebViewErrors.ErrorWithValue(let value) {
                replyHandler(nil, "Error with value: \(value)")
            } catch {
                replyHandler(nil, error.localizedDescription)
            }
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
            guard let requestURL = navigationAction.request.url?.absoluteString else { return }
            decisionHandler(.allow)
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            viewModel.isLoading = true
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.viewModel.isLoading = false
            }
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            viewModel.isLoading = false
        }
    }
}

enum WebViewErrors: Error {
    case ErrorWithValue(value: Int)
    case GenericError
}
