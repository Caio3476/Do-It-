//
//  CalendarTaskStore.swift
//  TodoListApp
//
//  Created by Caio Gentil Corado on 2025-07-22.
//

import SwiftUI

class CalendarTaskStore: ObservableObject {
    @Published var tasks: [CalendarTask] = []
    
    func addTask(_ task: CalendarTask) {
        tasks.append(task)
    }
}
