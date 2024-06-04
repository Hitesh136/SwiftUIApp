//
//  AddExpenseView.swift
//  SwiftUIApp
//
//  Created by HITESH AGARWAL on 13/05/24.
//

import SwiftUI

struct AddExpenseView: View {
    @Environment(\.dismiss) var dismiss
    @State var name: String = ""
    @State var type: String = "Business"
    @State var amount: Double = 0.0
    
    var expenseType = ["Business", "Personal"]
    var viewModel: Expense
    
    var body: some View {
        NavigationStack {
            
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(expenseType, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "INR"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add Expense")
            .toolbar {
                Button("Done") {
                    let expenseItem = ExpenseItem(name: name,
                                                  type: type,
                                                  amount: amount)
                    viewModel.items.append(expenseItem)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddExpenseView(viewModel: Expense())
}
