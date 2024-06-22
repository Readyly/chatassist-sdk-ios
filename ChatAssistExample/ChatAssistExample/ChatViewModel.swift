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
    var chat: Chat? = nil
    
    init() throws {
        let context = Chat.Context(baseUrl: ChatParams.url,
                                   licenseId: ChatParams.licenseId,
                                   orgName: ChatParams.orgName,
                                   profile: ChatParams.profile)
        chat = try Chat(context: context)
    }
    
    func startSession() -> some View {
        chat?.startSession()
    }
    
    func endSession() -> some View {
        chat?.endSession()
    }
}

struct ChatParams {
    static let url = "https://dev.daowxbrjd6wcz.amplifyapp.com"
    static let orgName = "help"
    static let profile = "christmas"
    static let licenseId = "AbCdE12"
}
