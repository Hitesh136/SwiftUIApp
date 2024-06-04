//
//  CupcakeCornerView.swift
//  SwiftUIApp
//
//  Created by HITESH AGARWAL on 31/05/24.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct SongsView: View {
    
    @State var result = [Result]()
    
    var body: some View {
        NavigationStack {
            List(result, id: \.trackId) { track in
                VStack(alignment: .leading) {
                    Text(track.trackName)
                        .font(.headline)
                    Text(track.collectionName)
                }
                
            }
            .navigationTitle("Songs")
        }
        
     
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let response = try? JSONDecoder().decode(Response.self, from: data) {
                result = response.results
            }
        } catch let error {
            print(error)
        }
    }
}

#Preview {
    SongsView()
}
