//
//  Context.swift
//  
//
//  Created by Mustafa Karakus on 20.06.2024.
//

import Foundation

extension Chat {
    public struct Context:Equatable {
        let baseUrl: String
        let orgName: String
        let profile: String?
        
        public init(baseUrl: String, orgName: String, profile: String?) {
            self.baseUrl = baseUrl
            self.orgName = orgName
            self.profile = profile
        }
        
        public static func == (lhs: Context, rhs: Context) -> Bool {
            return lhs.orgName == rhs.orgName &&
            lhs.baseUrl == rhs.baseUrl &&
            lhs.profile == rhs.profile
        }
    }
}
