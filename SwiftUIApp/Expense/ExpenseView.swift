//
//  ExpenseView.swift
//  SwiftUIApp
//
//  Created by HITESH AGARWAL on 13/05/24.
//

import SwiftUI

struct ExpenseItem: Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expense {
    var items = [ExpenseItem]() {
        didSet {
            let jsonEncoder = JSONEncoder()
            if let encodedValue = try? jsonEncoder.encode(items) {
                UserDefaults.standard.set(encodedValue, forKey: "expenses")
            }
        }
    }
    
    init() {
        if let decodedValue = UserDefaults.standard.data(forKey: "expenses"),
           let _items = try? JSONDecoder().decode([ExpenseItem].self, from: decodedValue) {
            self.items = _items
        }
    }
}

struct ExpenseView: View {
    
    @State var newWorld: String = ""
    @State var words = [String]()
    
    @State var numbers = [Int]()
    @State var currentNumber = 0
    
    @State var showAddExpense = false
    @State private var viewModel = Expense()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.items, id: \.name) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.title)
                                .fontWeight(.semibold)
                            Text(item.type)
                        }
                        Spacer()
                        Text("\(item.amount, format: .currency(code: "INRx"))")
                    }
                }
                .onDelete(perform: removeRow)
            }
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showAddExpense.toggle()
                }
            }
            .navigationTitle("iExpense")
        }
        .sheet(isPresented: $showAddExpense, content: {
            AddExpenseView(viewModel: viewModel)
        })
        .listStyle(.plain)
    }
    
    func removeRow(indexSet: IndexSet) {
        numbers.remove(atOffsets: indexSet)
    }
    
     
    func add() {
        withAnimation {
            
            words.insert(newWorld, at: 0)
        }
        newWorld = ""
    }
}

#Preview {
    ExpenseView()
}
