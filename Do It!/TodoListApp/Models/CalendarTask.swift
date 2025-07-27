//
//  CalendarTask.swift
//  TodoListApp
//
//  Created by Caio Gentil Corado on 2025-07-22.
//

import SwiftUI

struct CalendarTask: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var startTime: Date
    var duration: TimeInterval
    var color: Color
    var isAllDay: Bool = false
    var isTodoItem: Bool = false
    
    var endTime: Date {
        startTime.addingTimeInterval(duration)
    }
}
