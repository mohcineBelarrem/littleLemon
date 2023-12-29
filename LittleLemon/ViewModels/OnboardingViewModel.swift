//
//  OnboardingViewModel.swift
//  LittleLemon
//
//  Created by Mohcine BELARREM on 28/12/2023.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    
    
    func submit(firstName: String, lastName: String, email: String, completionHandler: (String) -> Void) {
        
        var errorMessage = ""
        
        if firstName.isEmpty {
            errorMessage += "First name Shouldn't be empty.\n"
        }
        
        if lastName.isEmpty {
            errorMessage += "Last name Shouldn't be empty.\n"
        }
        
        if email.isEmpty {
            errorMessage += "Email Shouldn't be empty.\n"
        }
        
        if !isValidEmail(email: email) {
            errorMessage += "Email should be valid."
        }
        
        if errorMessage.isEmpty {
            UserDefaults.standard.setValue(firstName, forKey: Constants.firstName.rawValue)
            UserDefaults.standard.setValue(lastName, forKey: Constants.lastName.rawValue)
            UserDefaults.standard.setValue(email, forKey: Constants.email.rawValue)
            UserDefaults.standard.setValue(true, forKey: Constants.isLoggedIn.rawValue)
        } else {
           completionHandler(errorMessage)
        }
        
    }
    
    private func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
