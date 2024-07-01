import Foundation
import SwiftUI

public struct Chat {
    let context: Context
    public let chatUrl: String
    private var view: ChatView? = nil
    private var viewModel: WebViewViewModel
    
    /// Initializes a `Chat` instance with the given context.
    /// - Parameter context: The context needed to build the chat URL.
    /// - Throws: `ChatError.invalidURL` if the URL cannot be constructed.
    public init(context: Context, delegate: ChatAssistDelegate? = nil) throws {
        self.context = context
        guard let url = UrlBuilder.build(context: self.context) else {
            throw ChatError.invalidURL
        }
        chatUrl = url
        viewModel = WebViewViewModel(webResource: chatUrl, delegate: delegate)
    }
     
    /// Starts the chat session
    public func startSession() -> some View {
        return ChatView(viewModel: viewModel)
    }
    
    /// Ends the chat session
    public func endSession() -> some View  {
        viewModel.delegate = nil
        return EmptyView()
    }
    
    public func postAction(action: Chat.Action) {
        viewModel.postAction(action: action)
    }
    public func postMessage(type: Chat.Message, payload: [String:Any]) {
        viewModel.postMessage(type: type, payload: payload)
    }
}
