//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Kazumasa Ohira on 2022/10/25.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    
}
