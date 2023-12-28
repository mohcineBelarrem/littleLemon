//
//  LittleLemonApp.swift
//  LittleLemon
//
//  Created by Mohcine on 27/12/2023.
//

import SwiftUI

@main
struct LittleLemonApp: App {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                HomeView()
            } else {
                OnboardingView()
            }
        }
    }
}
