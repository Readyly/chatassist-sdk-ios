//
//  File.swift
//
//
//  Created by Mustafa Karakus on 1.07.2024.
//

import Foundation

extension Chat {
    public enum Message: String {
        case userDetails = "_ft_user_details_",
             additionalDetails = "_ft_additional_details_"
    }
    public enum Action: String {
        case ready = "_ft_ready_",
             close = "_ft_close_"
    }
    
    struct MessagePayload: Decodable {
        let type:String
    }
}
