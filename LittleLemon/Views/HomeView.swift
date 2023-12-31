//
//  HomeView.swift
//  LittleLemon
//
//  Created by Mohcine BELARREM on 28/12/2023.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        TabView() {
            MenuView()
                .environment(\.managedObjectContext, viewContext)
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            UserProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.managedObjectContext,
                          PersistenceController.shared.container.viewContext)
    }
}
