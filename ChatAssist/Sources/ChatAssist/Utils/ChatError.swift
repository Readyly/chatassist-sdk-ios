//
//  ChatError.swift
//  
//
//  Created by Mustafa Karakus on 20.06.2024.
//

import Foundation

extension Chat {
    /// Errors that can occur when initializing `Chat`.
    enum ChatError: Error {
        case invalidURL
    }
}
