//
//  ListViewModel.swift
//  TodoListApp
//
//  Created by Paras, Gabby on 2025-07-17.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    weak var settings: SettingsViewModel?
    let itemsKey: String = "items_list"
    init() {
        getItems()
    }
    func getItems() {
        guard let data = UserDefaults.standard.data(forKey: itemsKey),
              let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        self.items = savedItems
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func deleteItemBy(id: String) {
        if let index = items.firstIndex(where: { $0.id == id }) {
            items.remove(at: index)
        }
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String, dueDate: Date? = nil) {
        let newItem = ItemModel(title: title, isComplete: false, dueDate: dueDate)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
            if let index = items.firstIndex(where: { $0.id == item.id }) {
                let updatedItem = items[index].updateCompletion()
                items[index] = updatedItem
                
                if let settings = settings, settings.autoDeleteCompleted && updatedItem.isComplete {
                    DispatchQueue.main.asyncAfter(deadline: .now() + settings.deleteDelay) {
                        self.deleteItemBy(id: updatedItem.id)
                    }
                }
            }
        }
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
