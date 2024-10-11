//
//  ContentView.swift
//  TactileButtons
//
//  Created by Wayne Dahlberg on 10/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      ZStack {
        Color(hex: "#F5F5F5").ignoresSafeArea()
        
        VStack(spacing: 20) {
          Button("Square") {
            print("Square button tapped")
          }
          .multilineTextAlignment(.center)
          .frame(width: 100, height: 100)
          .buttonStyle(.tactile())
          .padding(.top, 24)
          
          Button("Wide") {
            print("Wide button tapped")
          }
          .frame(width: 300, height: 50)
          .buttonStyle(.tactile())
          
          Button("Tall") {
            print("Tall button tapped")
          }
          .frame(width: 64, height: 132)
          .buttonStyle(.tactile())
        }
      }
    }
}

#Preview {
    ContentView()
}
