//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by HITESH AGARWAL on 05/05/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world! 1234")
            
            Button(action:  {
                ViewModel().fetchUser()
            }, label: {
                Text("Button")
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}


class ViewModel {
    
    func fetchUser() {
        let urlRequest = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/todos/1")!)
//        let urlRequest = URLRequest(url: URL(string: "https://reqres.in/api/users?page=2")!)
    
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(UserModel.self, from: data)
                    print("Result \(data)")
                    print(result.completed)
                    print(result.userId)
                    print(result.title)
                    print(result.id)
                    
                } catch let error {
                    print("Error: \(error)")
                }
            }
        }
        
        task.resume()
    }
}

class UserModel: Codable {
    var userId: Int?
    var id: Int?
    var title: String?
    var completed: Bool?
}
