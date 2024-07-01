//
//  ChatViewModel.swift
//  ChatAssistExample
//
//  Created by Mustafa Karakus on 22.06.2024.
//

import Foundation
import ChatAssist
import SwiftUI

@Observable
public class ChatViewModel {
     var chat: Chat?
     var isReady = false
     var isClosed = false
    
    init() {
        initialise()
    }
    
    func startSession() -> some View {
        if chat == nil {
            initialise()
        }
        return chat?.startSession()
    }
    
    func endSession() -> some View {
        chat?.endSession()
    }
    
    private func initialise() {
        let context = Chat.Context(baseUrl: ChatParams.url,
                                   orgName: ChatParams.orgName,
                                   profile: ChatParams.profile)
        do {
            chat = try Chat(context: context, delegate: self)
        } catch {
            print("Could not initialise the ChatAssist, error: \(error.localizedDescription)")
        }
    }
}

extension ChatViewModel: ChatAssistDelegate {
    public func chatDidReceiveReadyAction() {
        isReady = true
    }
    
    public func chatDidReceiveCloseAction() {
        isClosed = true
        _ = chat?.endSession()
        chat = nil
    }
}

struct ChatParams {
    static let url = "https://dev.daowxbrjd6wcz.amplifyapp.com"
    static let orgName = "help"
    static let profile = "christmas"
}
