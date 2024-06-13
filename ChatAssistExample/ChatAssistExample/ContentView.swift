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
    
    var body: some View {
        VStack {
            Button(action: {
                isSheetPresented.toggle()
            }) {
                Text("Show Chat")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            ChatView(url: URL(string: "https://www.youtube.com")!)
        }
    }
}

#Preview {
    ContentView()
}
