//
//  UserProfileView.swift
//  LittleLemon
//
//  Created by Mohcine BELARREM on 29/12/2023.
//

import SwiftUI

struct UserProfileView: View {
    @ObservedObject private var viewModel: UserProfileViewModel
    @Environment(\.presentationMode) var presentation
    
    @State var firstName: String
    @State var lastName: String
    @State var email: String
    
    @FocusState private var focusedField: Field?
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    init() {
        
        let userProfileViewModel = UserProfileViewModel()
        _viewModel = .init(initialValue: userProfileViewModel)
        _firstName = .init(initialValue: userProfileViewModel.firstName)
        _lastName = .init(initialValue: userProfileViewModel.lastName)
        _email = .init(initialValue: userProfileViewModel.email)
    }
    
    
    var body: some View {
        NavigationStack {
            List {
                
                Section(header: Text("First name")) {
                    TextField("First name", text: $firstName)
                        .focused($focusedField, equals: .firstName)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .lastName
                        }
                }
                
                Section(header: Text("Last name")) {
                    TextField("Last name", text: $lastName)
                        .focused($focusedField, equals: .lastName)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .email
                        }
                }
                
                Section(header: Text("Email")) {
                    TextField("Email", text: $email)
                        .focused($focusedField, equals: .email)
                        .submitLabel(.done)
                        .autocapitalization(.none)
                        .onSubmit {
                            print("submitting")
                        }
                }
                
                Section {
                    
                } footer: {
                    VStack(spacing: 40) {
                        HStack(alignment: .center) {
                            Button {
                                viewModel.logout() {
                                    self.presentation.wrappedValue.dismiss()
                                }
                            } label: {
                                Text("Log out")
                                    .font(.karlaBold(15))
                            }
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(Color.primaryTextColor)
                            .cornerRadius(5)
                        }
                        
                        HStack(spacing: 15) {
                            Button {
                                firstName = viewModel.firstName
                                lastName = viewModel.lastName
                                email = viewModel.email
                            } label: {
                                Text("Discard Changes")
                            }
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.primaryColor, lineWidth: 1)
                            )
                            .foregroundColor(.primaryColor)
                            
                            Button {
                                
                                viewModel.submit(firstName: firstName,
                                                 lastName: lastName,
                                                 email: email) { errorMessage in
                                    alertMessage = errorMessage
                                    showingAlert = true
                                }
                                
                            } label: {
                                Text("Save Changes")
                            }
                            .padding(10)
                            .background(Color.primaryColor)
                            .foregroundColor(.white)
                            
                        }
                        .font(.karlaBold(15))
                    }
                }
            }
            .alert(alertMessage, isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
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
