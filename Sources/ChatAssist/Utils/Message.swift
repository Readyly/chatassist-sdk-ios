//
//  Message.swift
//
//
//  Created by Mustafa Karakus on 1.07.2024.
//

import Foundation

extension Chat {
    public enum Message: String {
        case userDetails = "_ft_user_details_",
             additionalDetails = "_ft_additional_details_",
             resize = "_ft_window_resize_"
    }
    
    public enum Action {
        case ready
        case close
        case minimise //iPad
        case expand //iPad
        case error(String)
        
        private static let readyKey = "_ft_ready_"
        private static let closeKey = "_ft_close_"
        private static let minimiseKey = "_ft_minimize_"
        private static let expandKey = "_ft_expand_"
        private static let errorKey = "_ft_error_"
        
        var key: String {
            switch self {
            case .ready: return Self.readyKey
            case .close: return Self.closeKey
            case .minimise: return Self.minimiseKey
            case .expand: return Self.expandKey
            case .error: return Self.errorKey
            }
        }
    }
    
    struct MessagePayload: Decodable {
        let type:String
    }
}

extension Chat.Action: RawRepresentable {
    public init?(rawValue: String) {
        switch rawValue {
        case Chat.Action.readyKey:
            self = .ready
        case Chat.Action.closeKey:
            self = .close
        case Chat.Action.minimiseKey:
            self = .minimise
        case Chat.Action.expandKey:
            self = .expand
        default:
            if rawValue.starts(with: Chat.Action.errorKey) {
                let errorMessage = String(rawValue.dropFirst(Chat.Action.errorKey.count))
                self = .error(errorMessage)
            } else {
                return nil
            }
        }
    }
    
    public var rawValue: String {
        switch self {
        case .ready:
            return Chat.Action.readyKey
        case .close:
            return Chat.Action.closeKey
        case .minimise:
            return Chat.Action.minimiseKey
        case .expand:
            return Chat.Action.expandKey
        case .error(let message):
            return Chat.Action.errorKey + message
        }
    }
}
