//
//  MenuItemDetailView.swift
//  LittleLemon
//
//  Created by Mohcine BELARREM on 31/12/2023.
//

import SwiftUI

struct MenuItemDetailView: View {
    private var dish: Dish
    var body: some View {
        NavigationView {
            VStack {
                AsyncImage(url: URL(string: dish.image ?? "")) { image in
                    image
                        .resizable()
                        .frame(maxHeight: 300)
                } placeholder: {
                    Image("placeHolder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                VStack(alignment: .leading) {
                    Text(dish.title ?? "")
                        .font(.karlaRegular(20))
                    Text(dish.summary ?? "")
                        .font(.karlaRegular(13))
                        .lineLimit(2, reservesSpace: true)
                    Text(String(format: "$%.2f", dish.price))
                        .font(.karlaRegular(16))
                        .foregroundColor(.primaryColor)
                }
                Spacer()
            }
            .ignoresSafeArea(.all)
        }
    }
    
    init(dish: Dish) {
        self.dish = dish
    }
}

struct MenuItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemDetailView(dish: Dish(context: PersistenceController.shared.container.viewContext))
    }
}
