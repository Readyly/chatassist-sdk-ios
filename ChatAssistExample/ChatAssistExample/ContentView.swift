//
//  ContentView.swift
//  ChatAssistExample
//
//  Created by Mustafa Karakus on 12.06.2024.
//

import SwiftUI
import ChatAssist

struct ContentView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var isSheetPresented = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .trailing) {
                Button(action: {
                    print("button action")
                }) {
                    Text("Test")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }.padding()
                Spacer()
                if isSheetPresented {
                    viewModel.startSession()
                        .frame(height: UIScreen.main.bounds.height / 2)
                }
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
        }
        .onChange(of: viewModel.isReady) { isReady in
            if isReady {
                print("Chat is ready")
                isSheetPresented = true
            }
        }
        .onChange(of: viewModel.isClosed) { isClosed in
            if isClosed {
                print("Chat is closed")
                isSheetPresented = false
                viewModel.isClosed = false
            }
        }
        .onChange(of: viewModel.isMinimised) { isMinimised in
            if isMinimised {
                print("Chat is minimised")
            } else {
                print("Chat is expanded")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
} 
