//
//  LittleLemonApp.swift
//  LittleLemon
//
//  Created by Mohcine on 27/12/2023.
//

import SwiftUI

@main
struct LittleLemonApp: App {
    @AppStorage(Constants.isLoggedIn.rawValue) var isLoggedIn: Bool = false
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                HomeView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            } else {
                OnboardingView()
            }
        }
    }
}
