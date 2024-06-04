//
//  DetailView.swift
//  SwiftUIApp
//
//  Created by HITESH AGARWAL on 02/06/24.
//

import SwiftUI

struct DeliveryDetailView: View {
    
    @Bindable var order: Order
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $order.name)
                    TextField("Street Address", text: $order.streetAddress)
                    TextField("City", text: $order.city)
                    TextField("Zip", text: $order.zip)
                }
                
                Section {
                    
                    NavigationLink("Check out") {
                        CheckoutView(order: order)
                    }
                }
                .disabled(!order.canCheckOut())
            }
        }
    }
}

#Preview {
    DeliveryDetailView(order: Order())
}
