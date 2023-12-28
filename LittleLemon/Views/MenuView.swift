//
//  MenuView.swift
//  LittleLemon
//
//  Created by Mohcine BELARREM on 28/12/2023.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var viewModel = MenuViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.menuItems) { menuItem in
                    Text(menuItem.title)
                }
            }
        }
        .task {
           await viewModel.reload()
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
