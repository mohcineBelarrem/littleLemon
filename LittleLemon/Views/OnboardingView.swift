//
//  OnboardingView.swift
//  LittleLemon
//
//  Created by Mohcine BELARREM on 28/12/2023.
//

import SwiftUI

struct OnboardingView: View {
    
    enum Field: Hashable {
        case firstName
        case lastName
        case email
    }
    
    @ObservedObject private var viewModel = OnboardingViewModel()
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    
    @FocusState private var focusedField: Field?
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack() {
            
            Form {
                Section() {
                    TextField("First name", text: $firstName)
                        .focused($focusedField, equals: .firstName)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .lastName
                        }
                }
                
                Section() {
                    TextField("Last name", text: $lastName)
                        .focused($focusedField, equals: .lastName)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .email
                        }
                }
                
                
                Section() {
                    TextField("Email", text: $email)
                        .focused($focusedField, equals: .email)
                        .submitLabel(.done)
                        .onSubmit {
                            print("submitting")
                        }
                }
                
            }
            .scrollContentBackground(.hidden)
            .alert(alertMessage, isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
            
                Button {
                    viewModel.submit(firstName: firstName,
                                     lastName: lastName,
                                     email: email) { errorMessage in
                        alertMessage = errorMessage
                        showingAlert = true
                    }
                    
                } label: {
                    Text("Register")
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.primaryColor)
                }
                .font(.custom("MarkaziText-Regular", size: 30))
                .foregroundColor(.white)
                .cornerRadius(5)
                .padding()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
