//
//  EventModal.swift
//  TodoListApp
//
//  Created by Caio Gentil Corado on 2025-07-22.
//

import SwiftUI

struct EventModal: View {
    @EnvironmentObject var taskStore: CalendarTaskStore
    @EnvironmentObject var listViewModel: ListViewModel
    @EnvironmentObject var settings: SettingsViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var isAllDay = false
    @State private var startDate: Date
    @State private var endDate: Date
    @State private var isTodoItem = false
    
    let selectedDate: Date
    
    init(selectedDate: Date) {
        self.selectedDate = selectedDate
        let start = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: selectedDate) ?? selectedDate
        _startDate = State(initialValue: start)
        _endDate = State(initialValue: start.addingTimeInterval(3600))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                    
                    Toggle("Create as Todo Item", isOn: $isTodoItem)
                }
                
                Section(header: Text("Time")) {
                    Toggle("All Day", isOn: $isAllDay)
                    
                    if !isAllDay {
                        DatePicker("Starts",
                                   selection: $startDate,
                                   displayedComponents: [.date, .hourAndMinute]
                        )
                        .accentColor(settings.accentColor)
                        DatePicker("Ends",
                                   selection: $endDate,
                                   in: startDate...,
                                   displayedComponents: [.date, .hourAndMinute]
                        )
                    } else {
                        DatePicker("Date",
                                   selection: $startDate,
                                   displayedComponents: .date
                        )
                    }
                }
            }
            .navigationTitle("New Event")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addNewItem()
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
            .background(Color(.systemBackground))
        }
    }
    
    private func addNewItem() {
        if isTodoItem {
            
            listViewModel.addItem(title: title, dueDate: startDate)
        } else {
            
            let duration = isAllDay ? 86400 : endDate.timeIntervalSince(startDate)
            
            let newTask = CalendarTask(
                title: title,
                description: description,
                startTime: startDate,
                duration: duration,
                color: settings.accentColor,
                isAllDay: isAllDay
            )
            
            taskStore.addTask(newTask)
        }
    }
}
