//
//  Persistence.swift
//  Book Reviews
//
//  Created by Karl Cridland on 18/06/2025.
//

import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()

    /// For SwiftUI previews — creates mock data in memory
    @MainActor
    static let preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext

        // Sample Book
        let book = Book(context: viewContext)
        book.title = "Preview Book"
        book.authorName = "Preview Author"
        book.pages = 300

        // Sample Review
        let review = Review(context: viewContext)
        review.body = "This book was surprisingly good!"
        review.rating = 4
        review.date = Date()
        review.book = book

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error saving preview data: \(nsError), \(nsError.userInfo)")
        }

        return controller
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Book_Reviews")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved Core Data error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
