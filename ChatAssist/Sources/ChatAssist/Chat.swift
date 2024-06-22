import Foundation
import SwiftUI

public struct Chat {
    let context: Context
    public let chatUrl: String
    private var view: ChatView? = nil
    
    /// Initializes a `Chat` instance with the given context.
    /// - Parameter context: The context needed to build the chat URL.
    /// - Throws: `ChatError.invalidURL` if the URL cannot be constructed.
    public init(context: Context) throws {
        self.context = context
        guard let url = UrlBuilder.build(context: self.context) else {
            throw ChatError.invalidURL
        }
        chatUrl = url
    }
     
    /// Starts the chat session
    public func startSession() -> some View {
        let viewModel = WebViewViewModel(webResource: chatUrl)
        return ChatView(viewModel: viewModel)
    }
    
    /// Ends the chat session
    public func endSession() -> some View  {
        EmptyView()
    }
}
