//
//  Context.swift
//  
//
//  Created by Mustafa Karakus on 20.06.2024.
//

import Foundation

extension Chat {
    public struct Context:Equatable {
        let orgName: String
        let profile: String?
        
        public init(orgName: String, profile: String?) {
            self.orgName = orgName
            self.profile = profile
        }
        
        public static func == (lhs: Context, rhs: Context) -> Bool {
            return lhs.orgName == rhs.orgName &&
            lhs.profile == rhs.profile
        }
    }
}
