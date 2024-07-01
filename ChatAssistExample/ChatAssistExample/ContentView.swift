//
//  ContentView.swift
//  ChatAssistExample
//
//  Created by Mustafa Karakus on 12.06.2024.
//

import SwiftUI
import ChatAssist

struct ContentView: View {
    @State private var viewModel = ChatViewModel()
    @State private var isSheetPresented = false
    
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
        .fullScreenCover(isPresented: $isSheetPresented, onDismiss: {
            isSheetPresented = false
        }, content: {
            viewModel.startSession() 
        })
        .onChange(of: viewModel.isReady) {
            if viewModel.isReady {
                print("Chat is ready")
                isSheetPresented = true
            }
        }
        .onChange(of: viewModel.isClosed) {
            if viewModel.isClosed {
                print("Chat is closed")
                isSheetPresented = false
            }
        }
    }
}


#Preview {
    ContentView()
}
