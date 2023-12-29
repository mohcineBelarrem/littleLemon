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
    
    var body: some View {
        NavigationView {
            FetchedObjects(predicate: viewModel.predicate,
                           sortDescriptors: viewModel.sortDescriptors) { (dishes : [Dish]) in
                
                List {
                    ForEach(dishes) { dish in
                        Text(dish.title ?? "")
                    }
                }
            }
            
        }
        .task {
           await viewModel.reload(viewContext)
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
