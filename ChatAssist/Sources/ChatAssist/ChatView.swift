//
//  ChatView.swift
//
//
//  Created by Mustafa Karakus on 12.06.2024.
//

import SwiftUI

public struct ChatView: View {
    @State var viewModel:WebViewViewModel
    
    public var body: some View {
        ZStack {
            WebView(viewModel: viewModel)
                .edgesIgnoringSafeArea(.all)
            
            
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .cornerRadius(10)
                    .frame(width: 200, height: 200)
            }
            
        }.presentationBackground(.clear)
    }
}

#Preview {
    ChatView(viewModel: WebViewViewModel(webResource: ""))
}
