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
    
    @State private var selectedBook: BookResult?
    
    @State private var review = ""
    
    @State var startDate: Date = .now
    @State var finishDate: Date = .now
    
    @State private var plot: Int = 0
    @State private var writingStyle: Int = 0
    @State private var pacing: Int = 0
    @State private var characterDevelopment: Int = 0
    @State private var worldBuilding: Int = 0
    
    @State private var showingSelectBook = false
    
    var selected: Bool {
        return selectedBook != nil
    }
    
    var body: some View {
        Form {
            BookSelectorView(showingSelectBook: $showingSelectBook, selectedBook: $selectedBook)
            DatePickerView(startDate: $startDate, finishDate: $finishDate, selectedBook: $selectedBook)
            BookRaterView(score: $plot, selectedBook: $selectedBook, title: "Plot")
            BookRaterView(score: $writingStyle, selectedBook: $selectedBook, title: "Writing Style")
            BookRaterView(score: $pacing, selectedBook: $selectedBook, title: "Pacing")
            BookRaterView(score: $characterDevelopment, selectedBook: $selectedBook, title: "Character Development")
            BookRaterView(score: $worldBuilding, selectedBook: $selectedBook, title: "World Building")
            ThoughtsView(review: $review, selectedBook: $selectedBook)
        }
        .listSectionSpacing(16)
        .scrollContentBackground(.hidden)
        .contentMargins(.top, 20)
        .formStyle(.grouped)
        .navigationTitle("New Review")
        .navigationDestination(isPresented: $showingSelectBook) {
            SelectBookView(onBookSelected: { book in
                self.selectedBook = book
            })
            .environment(\.managedObjectContext, context)
            
        }
        .background(Color(.background))
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    if (selected) {
                        save()
                        dismiss()
                    }
                }
                .opacity(selected ? 1 : 0.6)
            }
        }
    }
    
    private func save() {
        if let selectedBook = self.selectedBook {
            let book = Book(context: context)
            book.id = selectedBook.id
            book.title = selectedBook.volumeInfo.title
            book.imageURL = selectedBook.volumeInfo.imageUrl
            book.authorName = selectedBook.authors
            ReviewManager.addReview(body: review, ratings: self.ratings, start: startDate, finish: finishDate, book: book, context: context)
        }
    }
    
    private var ratings: ReviewRatings {
        return ReviewRatings(
            plot: Int16(plot),
            pacing: Int16(pacing),
            writingStyle: Int16(writingStyle),
            worldBuilding: Int16(worldBuilding),
            characterDevelopment: Int16(characterDevelopment)
        )
    }
    
}

