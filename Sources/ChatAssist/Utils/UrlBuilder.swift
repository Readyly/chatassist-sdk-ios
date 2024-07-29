//
//  UrlBuilder.swift
//
//
//  Created by Mustafa Karakus on 20.06.2024.
//

import Foundation
import UIKit

let baseUrl = "https://chatassist.readyly.app"

extension Chat {
    public struct UrlBuilder {
        public static func build(context: Chat.Context) -> String? {
            guard var components = URLComponents(string: baseUrl),!context.orgName.isEmpty else {
                return nil
            }
            
            var queryItems = [
                URLQueryItem(name: "orgName", value: context.orgName.quotos),
                URLQueryItem(name: "platform", value: getDeviceType().quotos)
            ]
            
            if let profile = context.profile {
                queryItems.append(URLQueryItem(name: "profile", value: profile.quotos))
            }
            
            components.queryItems = queryItems
            return components.url?.absoluteString.replacingOccurrences(of: "?", with: "#")
        }
        
        private static func getDeviceType() -> String {
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                return "tablet_ios"
            default:
                return "mobile_ios"
            }
        }
    }
}

extension String {
    var quotos:String {
        "\"\(self)\""
    }
}
