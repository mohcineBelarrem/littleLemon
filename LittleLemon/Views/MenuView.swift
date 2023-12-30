//
//  MenuView.swift
//  LittleLemon
//
//  Created by Mohcine BELARREM on 28/12/2023.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject private var viewModel = MenuViewModel()
    
    @State private var searchText = ""
    @State private var selectedCategory = ""
    
    
    var body: some View {
        VStack() {
            Text("Little Lemon")
            Text("Chicago")
            Text("It's a restaurant ach bghiti")
            
            NavigationView {
                
               FetchedObjects(predicate: viewModel.buildPredicate(with: searchText, and: selectedCategory),
                               sortDescriptors: viewModel.sortDescriptors) { (dishes : [Dish]) in
                    
                    List {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(MenuItemCategory.allCases) { category in
                                    CategoryView(category: category.rawValue, selectedCategory: $selectedCategory) {
                                        if selectedCategory == category.rawValue {
                                            selectedCategory = ""
                                        } else {
                                            selectedCategory = category.rawValue
                                        }
                                    }
                                }
                            }
                        }
                        ForEach(dishes) { dish in
                            DishView(dish: dish)
                        }
                    }
                }
                
            }
            .searchable(text: $searchText, prompt: "Search...")
            //.scrollContentBackground(.hidden)
            .task {
                await viewModel.reload(viewContext)
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environment(\.managedObjectContext,
                          PersistenceController.shared.container.viewContext)
    }
}
