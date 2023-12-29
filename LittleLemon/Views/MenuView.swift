//
//  MenuView.swift
//  LittleLemon
//
//  Created by Mohcine BELARREM on 28/12/2023.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel = MenuViewModel()
    
    @State private var searchText = ""
    
    var body: some View {
        VStack() {
            Text("Little Lemon")
            Text("Chicago")
            Text("It's a restaurant ach bghiti")
            
            NavigationView {
                FetchedObjects(predicate: viewModel.buildPredicate(with: searchText),
                               sortDescriptors: viewModel.sortDescriptors) { (dishes : [Dish]) in
                    
                    List {
                        ForEach(dishes) { dish in
                            Text(dish.title ?? "")
                        }
                    }
                }
                
            }
            .searchable(text: $searchText, prompt: "Search...")
            .scrollContentBackground(.hidden)
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
