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
    @State private var rating = 3
    
    @State private var showingSelectBook = false
    
    var selected: Bool {
        return selectedBook != nil
    }
    
    var body: some View {
        Form {
            
            Section {
                Button {
                    showingSelectBook = true
                } label: {
                    HStack(spacing: 15, content: {
                        BookImage(urlString: selectedBook?.volumeInfo.imageUrl)
                        VStack(alignment: .leading, spacing: 5) {
                            Text(selected ? selectedBook?.volumeInfo.title ?? "" : "Select a book")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text(selected ? (selectedBook?.volumeInfo.authors?.joined(separator: ", ") ?? "") : "Which book did you just read?")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 6)
                        
                        Spacer()
                        
                        Image(systemName: selected ? "checkmark.circle" : "chevron.right")
                            .font(.system(size: selected ? 20 : 14, weight: .bold))
                            .foregroundColor(selected ? .lime : .secondary)
                    })
                }
            }
            
            Section {
                Stepper("Rating: \(rating)", value: $rating, in: 1...5)
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Your thoughts:")
                            .foregroundColor(.secondary)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .padding(.vertical, 10)

                        TextEditor(text: $review)
                            .frame(minHeight: 100)
                            .padding(4)
                            .background(Color(.systemGray6).opacity(0.8))
                            .cornerRadius(8)
                    }
                }
            }
            .opacity(selected ? 1 : 0.2)
            .padding(.bottom, 16)
        }
        .scrollContentBackground(.hidden)
        .contentMargins(.top, 20)
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
            ReviewManager.addReview(body: review, rating: Int16(rating), book: book, context: context)
        }
    }
    
}
