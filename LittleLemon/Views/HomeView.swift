//
//  HomeView.swift
//  LittleLemon
//
//  Created by Mohcine BELARREM on 28/12/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView() {
            MenuView()
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                    }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
