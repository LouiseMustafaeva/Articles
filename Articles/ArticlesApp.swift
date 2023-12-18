//
//  ArticlesApp.swift
//  Articles
//
//  Created by Louise on 18/12/23.
//

import SwiftUI

@main
struct ArticlesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
