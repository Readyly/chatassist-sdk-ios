//
//  ContentView.swift
//  ChatAssistExample
//
//  Created by Mustafa Karakus on 12.06.2024.
//

import SwiftUI
import ChatAssist

struct ContentView: View {
    @State private var isSheetPresented = false
    @State private var viewModel = try? ChatViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    isSheetPresented.toggle()
                }) {
                    Text("Chat with us")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
            }
        }
        .background(Color.blue.opacity(0.4))
        .fullScreenCover(isPresented: $isSheetPresented, content: {
            viewModel?.startSession()
        })
    }
}

#Preview {
    ContentView()
}
