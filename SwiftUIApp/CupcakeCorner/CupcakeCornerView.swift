//
//  CupcakeCornerView.swift
//  SwiftUIApp
//
//  Created by HITESH AGARWAL on 02/06/24.
//

import SwiftUI

struct CupcakeCornerView: View {
    
    @State var order: Order
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.selectedCakeIndex) {
                        ForEach(order.cakeTypes.indices, id: \.self) { typeIndex in
                            Text(order.cakeTypes[typeIndex])
                        }
                    }
                
                    Stepper("Number of cake: \(order.numberOfCake)", value: $order.numberOfCake)
                }
                
                Section {
                    Toggle("Any Special Request", isOn: $order.specialRequest)
                    
                    if order.specialRequest {
                        Toggle("Extra Frosting", isOn: $order.extraFrosting)
                        Toggle("Extra Sprinkles", isOn: $order.extraSprinkles)
                    }
                }
                
                Section {
                    NavigationLink("Delivery Details") {
                        DeliveryDetailView(order: order)
                    }
                }
            }
        }
    }
}

#Preview {
    CupcakeCornerView(order: Order())
}

@Observable
class Order: Codable {
    
    var cakeTypes = ["Vanilla", "Stawberry", "Chocolate", "Rainbow"]
    var selectedCakeIndex = 0
    var numberOfCake = 0
    
    var specialRequest = false {
        didSet {
            extraFrosting = false
            extraSprinkles = false
        }
    }
    
    var extraFrosting = false
    var extraSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    func canCheckOut() -> Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Decimal {
        // $2 per cake
        return 12
    }
}
