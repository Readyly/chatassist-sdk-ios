//
//  File.swift
//
//
//  Created by Mustafa Karakus on 20.06.2024.
//

import Foundation

extension Chat {
    public struct UrlBuilder {
        public static func build(context: Chat.Context) -> String? {
            guard var components = URLComponents(string: context.baseUrl),!context.orgName.isEmpty else {
                return nil
            }
            
            var queryItems = [
                URLQueryItem(name: "orgName", value: context.orgName.quotos),
                URLQueryItem(name: "platform", value: "mobile_ios".quotos)
            ]
            
            if let profile = context.profile {
                queryItems.append(URLQueryItem(name: "profile", value: profile.quotos))
            }
            
            components.queryItems = queryItems
            
            return components.url?.absoluteString.replacingOccurrences(of: "?", with: "#")
        }
    }
}

extension String {
    var quotos:String {
        "\"\(self)\""
    }
}
