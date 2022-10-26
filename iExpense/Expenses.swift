//
//  Expenses.swift
//  iExpense
//
//  Created by Kazumasa Ohira on 2022/10/25.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let savedItem = UserDefaults.standard.data(forKey: "Item") {
            if let decodedItem = try? JSONDecoder().decode([ExpenseItem].self, from: savedItem) {
                items = decodedItem
                return
            }
        }
        items = []
    }
}
