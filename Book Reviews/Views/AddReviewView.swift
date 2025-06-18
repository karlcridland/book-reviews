//
//  AddReviewView.swift
//  Book Reviews
//
//  Created by Karl Cridland on 18/06/2025.
//

import SwiftUI
import CoreData

struct AddReviewView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var context

    @State private var title = ""
    @State private var review = ""
    @State private var rating = 3

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Book Info")) {
                    TextField("Book Title", text: $title)
                }

                Section(header: Text("Review")) {
                    TextField("Your thoughts", text: $review)
                    Stepper("Rating: \(rating)", value: $rating, in: 1...5)
                }
            }
            .navigationTitle("New Review")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        save()
                        dismiss()
                    }
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func save() {
        // Check for empty title/review
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty,
              !review.trimmingCharacters(in: .whitespaces).isEmpty else { return }

        // Create a new Book (optional: de-duplicate in real apps)
        let book = Book(context: context)
        book.title = title

        // Add the review via your ReviewManager helper
        ReviewManager.addReview(body: review, rating: Int16(rating), book: book, context: context)
    }
}
