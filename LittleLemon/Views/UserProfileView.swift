//
//  UserProfileView.swift
//  LittleLemon
//
//  Created by Mohcine BELARREM on 29/12/2023.
//

import SwiftUI

struct UserProfileView: View {
    @ObservedObject private var viewModel = UserProfileViewModel()
    var body: some View {
        NavigationStack {
            List {
                
                Section(header: Text("First name")) {
                    Text(viewModel.firstName)
                }
                
                Section(header: Text("Last name")) {
                    Text(viewModel.lastName)
                }
                
                Section(header: Text("Email")) {
                    Text(viewModel.email)
                }
                
                Section {
                    
                } footer: {
                    HStack(alignment: .center) {
                        Spacer()
                        Button {
                            viewModel.logout()
                        } label: {
                            Text("Log out")
                                .font(.markaziMedium(25))
                        }
                        .foregroundColor(.red)
                        Spacer()
                            .background(Color.red)
                    }
                }
            }
            .formStyle(.grouped)
            .navigationTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
