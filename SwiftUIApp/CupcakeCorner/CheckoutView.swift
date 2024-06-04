//
//  CheckoutView.swift
//  SwiftUIApp
//
//  Created by HITESH AGARWAL on 02/06/24.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    @State var confirmationMessage = ""
    @State var showingConfirmation = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"),
                           scale: 3) { image in
                    
                    image.image?.resizable()
                        .scaledToFit()
                }
                  
                
                Text("Total cost is:$ \(order.cost)")
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Check out")
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.dark)
            .alert("Thank you", isPresented: $showingConfirmation, actions: {
                Button("OK") {}
                Button("Review") {}
            }, message: {
                Text(confirmationMessage)
                    .font(.largeTitle)
            })
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }

        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let order = try JSONDecoder().decode(Order.self, from: data)
            self.confirmationMessage = "Your order is ready: \(order)"
            self.showingConfirmation = true
        } catch let error {
            print(error)
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
