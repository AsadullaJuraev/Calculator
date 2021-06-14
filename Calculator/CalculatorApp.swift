//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Asadulla Juraev on 14.06.2021.
//

import SwiftUI

@main
struct CalculatorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
