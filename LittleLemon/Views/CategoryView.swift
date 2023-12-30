//
//  CategoryView.swift
//  LittleLemon
//
//  Created by Mohcine BELARREM on 30/12/2023.
//

import SwiftUI

struct CategoryView: View {
    let category: String
    @Binding var selectedCategory: String
    let action: () -> Void
    
    var textColor: Color {
        return selectedCategory == category ? .lightGray : .primaryColor
    }
    
    var backgroundColor: Color {
        return selectedCategory == category ? .primaryColor : .lightGray
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(category.capitalized)
        }
        .font(.callout)
        .fontWeight(.heavy)
        .foregroundColor(textColor)
        .padding()
        .background(backgroundColor)
        .cornerRadius(20)
       

    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: "Some", selectedCategory: .constant("Some")) {
            print("Hey")
        }
    }
}
