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
            VStack(alignment: .leading, spacing: 5) {
                Text("Little Lemon")
                    .font(.markaziSemiBold(50))
                    .padding(.leading)
                    .foregroundColor(.primaryTextColor)
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("Chicago")
                            .font(.markaziSemiBold(35))
                            .padding(.top, -15)
                        Text("We are a family owned Mediterranean restaurant, focused on traditional receipes with a modern twist.")
                            .font(.karlaMedium(18))
                        
                    }
                    .foregroundColor(.lightGray)
                    Image("heroImage")
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(width: 125)
                        .cornerRadius(20)
                }
                .padding([.leading,.trailing], 10)
                
                
                NavigationView {
                    
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
                                DishView(dish: dish)
                            }
                        }
                        //.padding(.top, 10)
                        .background(Color.primaryColor)
                        .scrollContentBackground(.hidden)
//                        .searchable(text: $searchText, prompt: "Search...")
//                        .onAppear {
//                            UISearchBar.appearance().tintColor = .red
//                            UISearchBar.appearance().searchTextField.backgroundColor = .blue
//                        }
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
