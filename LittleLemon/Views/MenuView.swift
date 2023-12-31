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
        ZStack() {
            Color.primaryColor
                .ignoresSafeArea(.all)
            
            NavigationView {
                VStack(alignment: .leading, spacing: -5) {
                    HeaderView()
                        .padding(-2)
                    
                    FetchedObjects(predicate: viewModel.buildPredicate(with: searchText, and: selectedCategory),
                                   sortDescriptors: viewModel.sortDescriptors) { (dishes : [Dish]) in
                        
                        List {
                            Section() {
                                TextField("Search...", text: $searchText)
                                    .listRowBackground(Color.lightGray)
                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                VStack(alignment: .leading) {
                                    Text("Order for delivery!".uppercased())
                                        .fontWeight(.heavy)
                                        .padding(10)
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
                            }
                            ForEach(dishes) { dish in
                                
                                NavigationLink {
                                    MenuItemDetailView(dish: dish)
                                } label: {
                                    DishView(dish: dish)
                                }
                            }
                        }
                        .background(Color.primaryColor)
                        .scrollContentBackground(.hidden)
                    }
                }
                .task {
                    await viewModel.reload(viewContext)
                }
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
