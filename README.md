# Do It! - Your Ultimate Task Manager 📝✨

A sleek todo list and calendar app that helps you organize tasks, track deadlines, and boost productivity with intuitive features.

## Features

### ✔️ Todo List
- Add tasks with optional due dates
- Swipe-to-complete with satisfying checkmark animation
- Auto-delete completed tasks (customizable delay)
- Haptic feedback on actions
- Filter to show/hide completed tasks
- Edit, delete, and rearrange tasks

### 📅 Smart Calendar
- Visualize tasks on their due dates
- Create events with start/end times
- Color-coded task types (todo items vs events)
- All-day event support
- Tap any date to view scheduled tasks

### 🎨 Personalized Experience
- Choose any accent colors
- Light/Dark/System appearance modes
- Customizable notification reminders
- Adjustable haptic feedback
- Set preferred task completion behavior

### ⚙️ One-Tap Settings
- Reset settings

## Getting Started

1. **Add Tasks**:
   - Tap "+" in Todo tab
   - Add title, description, and optional due date

2. **Complete Tasks**:
   - Tap any task to mark complete
   - Completed tasks automatically hide after delay (configurable)

3. **Calendar View**:
   - Switch to Calendar tab to see tasks by date
   - Tap "+" to create new calendar events

4. **Customize**:
   - Visit Settings tab to personalize colors and behavior

## Technical Details

- **Platform**: iOS 15+
- **Architecture**: MVVM with SwiftUI
- **Persistence**:
  - Todo items: UserDefaults + Codable
  - Calendar events: In-memory storage
- **Dependencies**: Pure SwiftUI (no third-party libraries)

## Installation

1. Clone this repository
2. Open `DoIt.xcodeproj` in Xcode 13+
3. Build and run on simulator or device

## Future Enhancements

- [ ] AI features to help users plan their tasks

---

Made with ❤️ and SwiftUI  
© Caio Gentil Corado and Gabriel Paras
