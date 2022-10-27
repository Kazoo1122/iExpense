//
//  ContentView.swift
//  iExpense
//
//  Created by Kazumasa Ohira on 2022/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    var personalExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Personal" }
    }
    var businessExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Business" }
    }
        
    var body: some View {
        NavigationView {
            VStack {
                Section {
                    List {
                        ForEach(personalExpenses) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            }
                            .foregroundColor(item.amount < 10 ? .black : item.amount < 100 ? .blue : .red)
                        }
                        .onDelete(perform: {removeItem(at: $0, type: "Personal")})
                    }
                } header: {
                    Text("Personal")
                }
                Section {
                    List {
                        ForEach(businessExpenses) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            }
                            .foregroundColor(item.amount < 10 ? .black : item.amount < 100 ? .blue : .red)
                        }
                        .onDelete(perform: {removeItem(at: $0, type: "Business")})
                    }
                } header: {
                    Text("Business")
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    func removeItem(at offsets: IndexSet, type: String) {
        for i in offsets {
            let deletedItem = expenses.items.filter { $0.type == type }[i]
            if let index = expenses.items.firstIndex(where: { $0.id == deletedItem.id }) {
                expenses.items.remove(at: index)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
