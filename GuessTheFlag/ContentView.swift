//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Marcel Mravec on 03.01.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        
        
        VStack {
            Button("Delete selection", role: .destructive, action: executeDelete)
            Button("Button 1") { }
                .buttonStyle(.bordered)
            Button("Button 2", role: .destructive) { }
                .buttonStyle(.bordered)
            Button("Button 3") { }
                .buttonStyle(.borderedProminent)
                .tint(.mint)
            Button("Button 4", role: .destructive) { }
                .buttonStyle(.borderedProminent)
        }
        }

                func executeDelete() {
                    print("Now deleting…")
                }
        
        
        
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
