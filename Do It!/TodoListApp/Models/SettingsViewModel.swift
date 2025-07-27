//
//  SettingsViewModel.swift
//  TodoListApp
//
//  Created by Caio Gentil Corado on 2025-07-22.
//

import Foundation
import SwiftUI

enum AppTheme: Int, CaseIterable {
    case system = 0
    case light = 1
    case dark = 2
    
    var name: String {
        switch self {
        case .system: return "System Default"
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }
    
    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}

class SettingsViewModel: ObservableObject {
    private enum Keys {
        static let accentColor = "accentColor"
        static let showCompletedTasks = "showCompletedTasks"
        static let notificationEnabled = "notificationEnabled"
        static let notificationTime = "notificationTime"
        static let hapticFeedbackEnabled = "hapticFeedbackEnabled"
        static let autoDeleteCompleted = "autoDeleteCompleted"
        static let deleteDelay = "deleteDelay"
        static let appTheme = "appTheme"
    }
    private let defaultAccentColor = Color.blue
    private let defaultShowCompletedTasks = true
    private let defaultNotificationEnabled = true
    private let defaultNotificationTime = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!
    private let defaultHapticFeedbackEnabled = true
    private let defaultAutoDeleteCompleted = true
    private let defaultDeleteDelay = 0.6
    private let defaultAppTheme = AppTheme.system

    @Published var accentColor: Color {
        didSet {
            saveColor(color: accentColor, key: Keys.accentColor)
        }
    }
    
    @Published var showCompletedTasks: Bool {
        didSet {
            UserDefaults.standard.set(showCompletedTasks, forKey: Keys.showCompletedTasks)
        }
    }
    
    @Published var notificationEnabled: Bool {
        didSet {
            UserDefaults.standard.set(notificationEnabled, forKey: Keys.notificationEnabled)
        }
    }
    
    @Published var notificationTime: Date {
        didSet {
            UserDefaults.standard.set(notificationTime, forKey: Keys.notificationTime)
        }
    }
    
    @Published var hapticFeedbackEnabled: Bool {
        didSet {
            UserDefaults.standard.set(hapticFeedbackEnabled, forKey: Keys.hapticFeedbackEnabled)
        }
    }
    
    @Published var autoDeleteCompleted: Bool {
        didSet {
            UserDefaults.standard.set(autoDeleteCompleted, forKey: Keys.autoDeleteCompleted)
        }
    }
    
    @Published var deleteDelay: Double {
        didSet {
            UserDefaults.standard.set(deleteDelay, forKey: Keys.deleteDelay)
        }
    }
    
    @Published var appTheme: AppTheme {
        didSet {
            UserDefaults.standard.set(appTheme.rawValue, forKey: Keys.appTheme)
        }
    }
    
    init() {
        if let colorData = UserDefaults.standard.data(forKey: Keys.accentColor),
           let uiColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData) {
            self.accentColor = Color(uiColor)
        } else {
            self.accentColor = .blue
        }
        
        self.showCompletedTasks = UserDefaults.standard.object(forKey: Keys.showCompletedTasks) as? Bool ?? true
        self.notificationEnabled = UserDefaults.standard.object(forKey: Keys.notificationEnabled) as? Bool ?? true
        self.notificationTime = UserDefaults.standard.object(forKey: Keys.notificationTime) as? Date ?? Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!
        self.hapticFeedbackEnabled = UserDefaults.standard.object(forKey: Keys.hapticFeedbackEnabled) as? Bool ?? true
        self.autoDeleteCompleted = UserDefaults.standard.object(forKey: Keys.autoDeleteCompleted) as? Bool ?? true
        self.deleteDelay = UserDefaults.standard.object(forKey: Keys.deleteDelay) as? Double ?? 0.6
        

        let themeRawValue = UserDefaults.standard.integer(forKey: Keys.appTheme)
        self.appTheme = AppTheme(rawValue: themeRawValue) ?? .system
    }
    
    private func saveColor(color: Color, key: String) {
        let uiColor = UIColor(color)
        if let colorData = try? NSKeyedArchiver.archivedData(withRootObject: uiColor, requiringSecureCoding: false) {
            UserDefaults.standard.set(colorData, forKey: key)
        }
    }
    func resetToDefaults() {
            accentColor = defaultAccentColor
            showCompletedTasks = defaultShowCompletedTasks
            notificationEnabled = defaultNotificationEnabled
            notificationTime = defaultNotificationTime
            hapticFeedbackEnabled = defaultHapticFeedbackEnabled
            autoDeleteCompleted = defaultAutoDeleteCompleted
            deleteDelay = defaultDeleteDelay
            appTheme = defaultAppTheme
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        }
}
