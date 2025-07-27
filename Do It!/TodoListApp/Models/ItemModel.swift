//
//  ItemModel.swift
//  TodoListApp
//
//  Created by Paras, Gabby on 2025-07-16.
//

import Foundation

struct ItemModel: Identifiable, Codable {
    let id: String
    let title: String
    let isComplete: Bool
    var dueDate: Date?
    
    init(id: String = UUID().uuidString, title: String, isComplete: Bool, dueDate: Date? = nil) {
        self.id = id
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(
            id: id,
            title: title,
            isComplete: !isComplete,
            dueDate: dueDate
        )
    }
}
