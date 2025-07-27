//
//  ListRowView.swift
//  TodoListApp
//
//  Created by Paras, Gabby on 2025-07-16.
//

import SwiftUI

struct ListRowView: View {
    let item: ItemModel
    @EnvironmentObject var settings: SettingsViewModel
    
    var body: some View {
        HStack {
            Image(systemName: item.isComplete ? "checkmark.circle.fill" : "circle")
                .foregroundColor(item.isComplete ? .green : settings.accentColor)
                .font(.title2)
            
            VStack(alignment: .leading) {
                Text(item.title)
                    .strikethrough(item.isComplete)
                
                if let dueDate = item.dueDate {
                    Text(dueDate, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
    }
    
    
    struct ListRowView_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                ListRowView(item: ItemModel(title: "First item!", isComplete: false, dueDate: Date()))
                ListRowView(item: ItemModel(title: "Second item!", isComplete: true))
            }
            .previewLayout(.sizeThatFits)
        }
    }
}
