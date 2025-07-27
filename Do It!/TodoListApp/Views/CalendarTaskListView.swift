//
//  CalendarTaskListView.swift
//  TodoListApp
//
//  Created by Caio Gentil Corado on 2025-07-22.
//

import SwiftUI

struct CalendarTaskListView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    @EnvironmentObject var taskStore: CalendarTaskStore
    @EnvironmentObject var settings: SettingsViewModel
    
    let selectedDate: Date
    
    private var allTasksForSelectedDate: [CalendarTask] {
        let calendar = Calendar.current
        
        let calendarTasks = taskStore.tasks.filter {
            calendar.isDate($0.startTime, inSameDayAs: selectedDate)
        }
        
      
        let todoTasks = listViewModel.items.filter { item in
            if let dueDate = item.dueDate {
                return calendar.isDate(dueDate, inSameDayAs: selectedDate)
            }
            return false
        }.map { item -> CalendarTask in
            CalendarTask(
                title: item.title,
                description: item.isComplete ? "Completed" : "Pending",
                startTime: item.dueDate!,
                duration: 3600,
                color: item.isComplete ? .green : .orange,
                isTodoItem: true
            )
        }
        
        return calendarTasks + todoTasks
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Tasks for \(selectedDate.formatted(date: .long, time: .omitted))")
                .font(.headline)
                .padding(.horizontal)
                .padding(.top)
            
            if allTasksForSelectedDate.isEmpty {
                Text("No tasks for this date")
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(allTasksForSelectedDate) { task in
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Circle()
                                        .fill(task.isTodoItem ? task.color : settings.accentColor)
                                        .frame(width: 12, height: 12)
                                    
                                    VStack(alignment: .leading) {
                                        Text(task.title)
                                            .font(.headline)
                                        
                                        if task.isTodoItem {
                                            Text("Todo Item")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    if task.isAllDay {
                                        Text("All Day")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    } else {
                                        Text(task.startTime, style: .time)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                
                                if !task.description.isEmpty {
                                    Text(task.description)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(12)
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom)
                }
            }
        }
        .background(Color(.systemBackground))
    }
}

struct CalendarTaskView: View {
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
                    
                    if task.isTodoItem {
                        Text("Todo Item")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                if task.isAllDay {
                    Text("All Day")
                        .font(.caption)
                } else {
                    Text(task.startTime, style: .time)
                        .font(.subheadline)
                }
            }
            
            if !task.description.isEmpty {
                Text(task.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
