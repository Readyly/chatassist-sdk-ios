//
//  ChatView.swift
//
//
//  Created by Mustafa Karakus on 12.06.2024.
//

import SwiftUI

public struct ChatView: View {
    @StateObject var viewModel:WebViewViewModel
    
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
            
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(viewModel: WebViewViewModel(webResource: ""))
    }
}
