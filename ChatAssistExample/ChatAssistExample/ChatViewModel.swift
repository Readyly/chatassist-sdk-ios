//
//  ChatViewModel.swift
//  ChatAssistExample
//
//  Created by Mustafa Karakus on 22.06.2024.
//

import Foundation
import ChatAssist
import SwiftUI

public class ChatViewModel: ObservableObject {
    @Published var chat: Chat?
    @Published var isReady = false
    @Published var isClosed = false
    @Published var isMinimised = false
    
    init() {
        initialise()
    }
    
    func startSession() -> some View {
        if chat == nil {
            initialise()
        }
        return chat?.startSession()
    }
    
    func endSession() {
        chat?.endSession()
    }
    
    private func initialise() {
        let context = Chat.Context(orgName: ChatParams.orgName,
                                   profile: ChatParams.profile)
        do {
            chat = try Chat(context: context, delegate: self)
        } catch {
            print("Could not initialise the ChatAssist, error: \(error.localizedDescription)")
        }
    }
}

extension ChatViewModel: ChatAssistDelegate {
    public func chatDidReceiveErrorAction(message: String) {
        print("Error occured: \(message)")
    }
    
    public func chatDidReceiveReadyAction() {
        isReady = true
        isClosed = false
    }
    
    public func chatDidReceiveCloseAction() {
        isReady = false
        isClosed = true
    }
    
    public func chatDidReceiveExpandAction() {
        isMinimised = false
    }
    
    public func chatDidReceiveMinimiseAction() {
        isMinimised = true
    }
}

struct ChatParams {
    static let orgName = "help"
    static let profile = "default"
}
