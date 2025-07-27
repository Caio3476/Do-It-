//
//  NoItemsView.swift
//  TodoListApp
//
//  Created by Paras, Gabby on 2025-07-21.
//

import SwiftUI

struct NoItemsView: View {
    @State var animate: Bool = false
    @EnvironmentObject var settings: SettingsViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                Text("There are no items!")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom, 10)
                
                Text("It's time for you to escape the procastination hole! To solve that, click the add button to solve your first task of the day!")
                    .padding(.bottom, 20)
                
                NavigationLink(destination: AddView(), label: {
                    Text("Add Your Task!!!")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(animate ? settings.accentColor.opacity(0.7) : settings.accentColor)
                        .cornerRadius(10)
                })
                .padding(.horizontal, animate ? 30 : 50)
                .shadow(
                    color: settings.accentColor.opacity(animate ? 0.7 : 0.4),
                    radius: animate ? 30 : 10,
                    x: 0, y: animate ? 30 : 10
                )
                .scaleEffect(animate ? 1.1 : 1.0)
                .offset(y: animate ? -7 : 0)
            }
            .frame(maxWidth: 400)
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}


struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoItemsView()
                .navigationTitle("Title")
        }
    }
}
