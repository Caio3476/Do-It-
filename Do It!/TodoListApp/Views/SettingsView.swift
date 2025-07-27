//
//  SettingsView.swift
//  TodoListApp
//
//  Created by Caio Gentil Corado on 2025-07-22.
//


import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: SettingsViewModel
    @EnvironmentObject var listViewModel: ListViewModel
    @EnvironmentObject var taskStore: CalendarTaskStore
    @State private var showingResetSettingsAlert = false
    
    var body: some View {
        Form {
            Section(header: Text("Appearance")) {
                ColorPicker("Accent Color", selection: $settings.accentColor)
                
                Toggle("Show Completed Tasks", isOn: $settings.showCompletedTasks)
                
                Picker("Color Scheme", selection: $settings.appTheme) {
                    ForEach(AppTheme.allCases, id: \.self) { theme in
                        Text(theme.name).tag(theme)
                    }
                }
            }
            
            Section(header: Text("Task Completion")) {
                Toggle("Auto-delete Completed", isOn: $settings.autoDeleteCompleted)
                
                if settings.autoDeleteCompleted {
                    VStack(alignment: .leading) {
                        Text("Delete Delay: \(Int(settings.deleteDelay * 1000))ms")
                        Slider(value: $settings.deleteDelay, in: 0.1...2.0, step: 0.1)
                    }
                }
                
                Toggle("Haptic Feedback", isOn: $settings.hapticFeedbackEnabled)
            }
            
            Section(header: Text("Notifications")) {
                Toggle("Enable Reminders", isOn: $settings.notificationEnabled)
                
                if settings.notificationEnabled {
                    DatePicker("Daily Reminder Time",
                               selection: $settings.notificationTime,
                               displayedComponents: .hourAndMinute)
                }
            }
            Section(header: Text("Data Manangement")){
                Button("Reset Settings to Defaults", role: .destructive){
                    showingResetSettingsAlert = true
                }
            }
        }
        .navigationTitle("Settings")
        .alert("Reset Settings to Defaults?", isPresented: $showingResetSettingsAlert){
            Button("Reset", role: .destructive){
                settings.resetToDefaults()
            }
            Button("Cancel", role: .cancel){}
        } message: {
            Text("This will reset all settings to their default values. Your data will not be affected.")
        }
        .background(Color(.systemBackground))
    }
    
}
