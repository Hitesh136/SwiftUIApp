//
//  SplitView.swift
//  SwiftUIApp
//
//  Created by HITESH AGARWAL on 08/05/24.
//

import SwiftUI

struct SplitView: View {
    
    @State var checkAmount = 0.0
    @State var numberOfPeople = 2
    @State var tipPercantage = 20
    @State var selectedName: String = "One"
    @FocusState private var isAmountFieldFocused: Bool
    
    var tips = [10, 20, 30, 40 ,50]
    
    var names = ["One", "Two", "Three"]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercantage)

        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
        
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Check amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isAmountFieldFocused)
                    
                    Picker("Peoples", selection: $numberOfPeople) {
                        ForEach(0..<100) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much you wana tip") {
                    Picker("Tip Percantage", selection: $tipPercantage) {
                        ForEach(tips, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Text("Check Amount: \(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                }
            }
            .navigationTitle("Form")
            .toolbar{
                if isAmountFieldFocused {
                    Button("Done") {
                        isAmountFieldFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    SplitView()
}
