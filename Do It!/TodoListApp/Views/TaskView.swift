//
//  TaskView.swift
//  TodoListApp
//
//  Created by Caio Gentil Corado on 2025-07-22.
//

import SwiftUI

struct TaskView: View {
    let task: CalendarTask
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Circle()
                    .fill(task.color)
                    .frame(width: 12, height: 12)
                
                VStack(alignment: .leading) {
                    Text(task.title)
                        .font(.headline)
                        .foregroundColor(.appTextPrimary)
                    
                    if task.isTodoItem {
                        Text("Todo Item")
                            .font(.caption)
                            .foregroundColor(.appTextSecondary)
                    }
                }
                
                Spacer()
                
                if task.isAllDay {
                    Text("All Day")
                        .font(.caption)
                        .foregroundColor(.appTextSecondary)
                } else {
                    Text(task.startTime, style: .time)
                        .font(.subheadline)
                }
            }
            
            if !task.description.isEmpty {
                Text(task.description)
                    .font(.subheadline)
                    .foregroundColor(.appTextSecondary)
            }
        }
        .padding()
        .background(Color.appContainer)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
