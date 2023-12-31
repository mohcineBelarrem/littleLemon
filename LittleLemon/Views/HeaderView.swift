//
//  HeaderView.swift
//  LittleLemon
//
//  Created by Mohcine BELARREM on 31/12/2023.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
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
            .padding([.leading,.trailing], 15)
        }
        .background(Color.primaryColor)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
