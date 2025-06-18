//
//  Book_ReviewsApp.swift
//  Book Reviews
//
//  Created by Karl Cridland on 18/06/2025.
//

import SwiftUI

@main
struct BookReviewsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
              .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
