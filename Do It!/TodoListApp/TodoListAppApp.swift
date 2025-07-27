//
//  TodoListAppApp.swift
//  TodoListApp
//
//  Created by Paras, Gabby on 2025-07-16.
//

import SwiftUI

@main
struct TodoListAppApp: App {
    @StateObject private var settings = SettingsViewModel()
    @StateObject private var listViewModel = ListViewModel()
    @StateObject private var taskStore = CalendarTaskStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
                .environmentObject(listViewModel)
                .environmentObject(taskStore)
                .onAppear {
                    listViewModel.settings = settings
                }
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var settings: SettingsViewModel
    @EnvironmentObject var listViewModel: ListViewModel
    @EnvironmentObject var taskStore: CalendarTaskStore
    
    var body: some View {
        TabView {
            // Todo List Tab
            NavigationView {
                ListView()
            }
            .tabItem {
                Label("To Do", systemImage: "list.bullet")
            }
            
            // Calendar Tab
            NavigationView {
                CalendarView()
            }
            .tabItem {
                Label("Calendar", systemImage: "calendar")
            }
            
            // Settings Tab
            NavigationView {
                SettingsView()
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape")
            }
        }
        .accentColor(settings.accentColor)
        .preferredColorScheme(settings.appTheme.colorScheme)
    }
}
