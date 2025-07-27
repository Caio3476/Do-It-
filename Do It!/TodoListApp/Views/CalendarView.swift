//
//  CalendarView.swift
//  TodoListApp
//
//  Created by Caio Gentil Corado on 2025-07-22.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    @EnvironmentObject var taskStore: CalendarTaskStore
    @EnvironmentObject var settings: SettingsViewModel
    
    @State private var selectedDate = Date()
    @State private var showingEventModal = false
    
    var body: some View {
        VStack {
            
            DatePicker("Selected Date",
                       selection: $selectedDate,
                       displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(12)
            .padding(.horizontal)
            
            
            CalendarTaskListView(selectedDate: selectedDate)
                .environmentObject(listViewModel)
                .environmentObject(taskStore)
                .environmentObject(settings)
            
            Spacer()
        }
        .navigationTitle("Calendar")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: { showingEventModal = true }) {
                    Image(systemName: "plus")
                        .font(.headline)
                }
            }
        }
        .sheet(isPresented: $showingEventModal) {
            EventModal(selectedDate: selectedDate)
                .environmentObject(taskStore)
                .environmentObject(listViewModel)
                .environmentObject(settings)
        }
        .background(Color(.systemBackground))
    }
}
