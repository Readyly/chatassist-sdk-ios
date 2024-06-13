//
//  ChatView.swift
//  
//
//  Created by Mustafa Karakus on 12.06.2024.
//

import SwiftUI

public struct ChatView: View {
    let url: URL
    @State private var isLoading = true

    public init(url: URL, isLoading: Bool = true) {
        self.url = url
        self.isLoading = isLoading
    }
    
    public var body: some View {
        ZStack {
            WebView(url: url, isLoading: $isLoading)
                .edgesIgnoringSafeArea(.all)

            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    ChatView(url: URL(string: "https://www.youtube.com")!)
}
