//
//  UserProfileViewModel.swift
//  LittleLemon
//
//  Created by Mohcine BELARREM on 29/12/2023.
//

import Foundation

class UserProfileViewModel: ObservableObject {
    
    var firstName: String {
        return UserDefaults.standard.string(forKey: Constants.firstName.rawValue) ?? ""
    }
    
    var lastName: String {
        return UserDefaults.standard.string(forKey: Constants.lastName.rawValue) ?? ""
    }

    var email: String {
        return UserDefaults.standard.string(forKey: Constants.email.rawValue) ?? ""
    }
    
    func logout(completion: () -> ()) {
        UserDefaults.standard.set(false, forKey: Constants.isLoggedIn.rawValue)
        completion()
    }
    
}
