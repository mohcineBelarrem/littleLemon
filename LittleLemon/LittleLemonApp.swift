//
//  LittleLemonApp.swift
//  LittleLemon
//
//  Created by Mohcine on 27/12/2023.
//

import SwiftUI

@main
struct LittleLemonApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            OnboardingView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
