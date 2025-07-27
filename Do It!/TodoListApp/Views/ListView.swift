//
//  ListView.swift
//  TodoListApp
//
//  Created by Paras, Gabby on 2025-07-16.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    @EnvironmentObject var settings: SettingsViewModel
    
    var filteredItems: [ItemModel] {
        settings.showCompletedTasks ?
            listViewModel.items :
            listViewModel.items.filter { !$0.isComplete }
    }
    
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else if filteredItems.isEmpty {
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                List {
                    ForEach(filteredItems) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear) {
                                    let updatedItem = item.updateCompletion()
                                    
                                    
                                    listViewModel.updateItem(item: item)
                                    
                                    if settings.hapticFeedbackEnabled {
                                        let generator = UIImpactFeedbackGenerator(style: .medium)
                                        generator.impactOccurred()
                                    }
                                }
                            }
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Do It! 📝")
        .navigationBarItems(
            leading: EditButton(),
            trailing: NavigationLink("Add", destination: AddView())
        )
        .background(Color(.systemBackground))
    }
}


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}
