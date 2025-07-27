//
//  AddView.swift
//  TodoListApp
//
//  Created by Paras, Gabby on 2025-07-16.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @EnvironmentObject var settings: SettingsViewModel
    
    @State var textFieldText: String = ""
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    @State var dueDate: Date? = nil
    @State var addDueDate: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Task title...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                
                Toggle("Add due date", isOn: $addDueDate)
                    .padding(.top)
                
                if addDueDate {
                    DatePicker("Due Date",
                               selection: Binding<Date>(
                                get: { dueDate ?? Date() },
                                set: { dueDate = $0 }
                               ),
                               displayedComponents: [.date, .hourAndMinute]
                    )
                    .datePickerStyle(.compact)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                }
                
                Button(action: saveButtonPressed, label: {
                    Text("Save Task")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(settings.accentColor)
                        .cornerRadius(10)
                })
                .padding(.top)
            }
            .padding(14)
        }
        .navigationTitle("Add New Task 🖊️")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            listViewModel.addItem(
                title: textFieldText,
                dueDate: addDueDate ? dueDate : nil
            )
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 {
            alertTitle = "Task must be at least 3 characters long!"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        Alert(title: Text(alertTitle))
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AddView()
            }
            .preferredColorScheme(.light)
            .environmentObject(ListViewModel())
        
            NavigationView {
                AddView()
            }
            .preferredColorScheme(.dark)
            .environmentObject(ListViewModel())
        }
    }
}
