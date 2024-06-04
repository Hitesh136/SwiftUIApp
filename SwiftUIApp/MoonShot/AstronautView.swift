//
//  AstronautView.swift
//  SwiftUIApp
//
//  Created by HITESH AGARWAL on 29/05/24.
//

import SwiftUI

struct AstronautView: View {
    
    var astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            Image(astronaut.id)
                .resizable()
                .scaledToFit()
            
            Text(astronaut.description)
                .foregroundStyle(.white)
                .padding()
        }
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return AstronautView(astronaut: astronauts["aldrin"]!)
}
