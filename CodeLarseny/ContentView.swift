//
//  ContentView.swift
//  CodeLarseny
//
//  Created by Daniel Larsen on 1/2/21.
//

import SwiftUI
import XcodeLarseny

struct ContentView: View {
    
    @State var playgroundDirectory: String = DefaultPlaygroundDirectory.path ?? "<None assigned. Your bad>"
    
    var body: some View {
        HStack {
            Image("hacker-simulator")
                .frame(width: 200.0)
                .offset(x: 85, y: 0)
                .clipped()
            VStack(alignment: .leading, spacing: 36) {
                Text("Welcome, Hacker")
                    .font(.title)
                Text("You'll want to be adjusting some dials and settings now.")
                
                VStack(alignment: .leading) {
                    Text("Current Default Playground Directory:")
                        .font(.caption)
                    Text(playgroundDirectory)
                        .italic()
                        .font(.caption2)
                }
                .foregroundColor(.gray)

                Button(action: {
                    if let defaultURL = PlaygroundFolderPicker.chooseFolder() {
                        DefaultPlaygroundDirectory.url = defaultURL
                        playgroundDirectory = defaultURL.path
                    }
                }, label: {
                    Text("Plaground Directory")
                })
            }
            .frame(minWidth: 250, alignment: .leading)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
