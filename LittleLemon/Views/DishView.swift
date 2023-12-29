//
//  DishView.swift
//  LittleLemon
//
//  Created by Mohcine BELARREM on 29/12/2023.
//

import SwiftUI

struct DishView: View {
    private var dish: Dish
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image
                    .resizable()
                    .frame(width: 100, height: 60)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
            } placeholder: {
                Image("placeHolder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 60)
                    .cornerRadius(10)
            }
            
            Spacer()
                .frame(maxWidth: 20)

            VStack(alignment: .leading) {
                Text(dish.title ?? "")
                    .font(.karlaRegular(20))
                Text(String(format: "$%.2f", dish.price))
                    .font(.karlaRegular(16))
                    .foregroundColor(.primaryColor)
            }
        }
    }
    
    init(dish: Dish) {
        self.dish = dish
    }
}

struct DishView_Previews: PreviewProvider {
    static var previews: some View {
        DishView(dish: Dish(context: PersistenceController.shared.container.viewContext))
    }
}
