//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by HITESH AGARWAL on 05/05/24.
//

import SwiftUI
 
struct DetailView: View {
    
    var number: Int
    @Binding var path: NavigationPath
    
    var body: some View {
         NavigationLink("Navigate to \(number + 1)", value: number + 1)
            .navigationTitle("Number \(number)")
            .toolbar {
                Button("Home") {
                    path = NavigationPath()
                }
            }
    }
}

struct ContentView: View {
     
    @State var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            DetailView(number: 0, path: $path)
                .navigationDestination(for: Int.self) { number in
                    DetailView(number: number, path: $path)
                }
        }
        
    }
}

#Preview {
    ContentView()
}
