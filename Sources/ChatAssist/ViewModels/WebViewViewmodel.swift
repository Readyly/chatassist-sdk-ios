//
//  WebViewViewModel.swift
//
//
//  Created by Mustafa Karakus on 14.06.2024.
//

import SwiftUI
import WebKit

public class WebViewViewModel: ObservableObject {
    var webResource: String?
    var webView: WKWebView
    @Published var messageFromWV: String = ""
    @Published var isLoading: Bool = false
    @Published var lastState: Chat.Action = .ready
    weak var delegate: ChatAssistDelegate?
    
    public init(webResource: String? = nil, delegate: ChatAssistDelegate? = nil) {
        self.webResource = webResource
        self.delegate = delegate
        let configuration = WKWebViewConfiguration()
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        configuration.defaultWebpagePreferences = preferences
        self.webView = WKWebView(frame: .zero,
                                 configuration: configuration)
        self.webView.isOpaque = false
        self.webView.backgroundColor = UIColor.clear
        loadUrl()
        
#if DEBUG
        if #available(iOS 16.4, *) {
            self.webView.isInspectable = true
        }
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
    
    private func checkResize() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            postMessage(type: .resize, payload: ["width":768, "height":1024])
        }
    }
    
    func receivedAction(_ action: Chat.Action) {
        switch action {
        case .ready:
            checkResize()
            delegate?.chatDidReceiveReadyAction()
        case .close:
            reset()
            delegate?.chatDidReceiveCloseAction()
        case .minimise:
            delegate?.chatDidReceiveMinimiseAction?()
        case .expand:
            delegate?.chatDidReceiveExpandAction?()
        case .error(let message):
            delegate?.chatDidReceiveErrorAction(message: message)
        }
        lastState = action
    }
    
    func postAction(action: Chat.Action) {
        postMessage(type: action.rawValue)
    }
    
    func postMessage(type: Chat.Message, payload: [String:Any]) {
        postMessage(type: type.rawValue, payload: payload)
    }
    
    
    private func postMessage(type: String, payload: [String:Any]? = nil) {
        var messageDict: [String: Any] = ["type": type]
        
        if let payload = payload {
            messageDict["payload"] = payload
        }
        
        do {
            let messageData = try JSONSerialization.data(withJSONObject: messageDict, options: [])
            if let messageString = String(data: messageData, encoding: .utf8) {
                let script = "window.postMessage('\(messageString)', window.location.origin)"
                evaluateJavaScript(script)
            }
        } catch {
            print("Failed to send the message: \(error)")
        }
        
    }
    
    private func evaluateJavaScript(_ script: String) {
        self.webView.evaluateJavaScript(script) { (result, error) in
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
    
    public func loadUrl() {
        if let webResource = webResource {
            guard let url = URL(string: webResource) else {
                print("Bad URL")
                return
            }
            load(url: url)
        }
    }
    
    private func reset() {
        load(url: URL(string: "about:blank")!)
    }
    
    private func load(url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

@objc public protocol ChatAssistDelegate {
    func chatDidReceiveErrorAction(message:String)
    func chatDidReceiveReadyAction()
    func chatDidReceiveCloseAction()
    @objc optional func chatDidReceiveMinimiseAction()
    @objc optional func chatDidReceiveExpandAction()
}
