//
//  ContentView.swift
//  Book Reviews
//
//  Created by Karl Cridland on 18/06/2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var context

    @FetchRequest(
        entity: Review.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Review.date, ascending: false)]
    ) private var reviews: FetchedResults<Review>

    @State private var showingAdd = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(reviews) { review in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(review.book?.title ?? "Unknown Book")
                            .font(.headline)
                        Text("Rating: \(review.rating)")
                        Text(review.body ?? "No review.")
                            .font(.subheadline)
                    }
                    .padding(.vertical, 4)
                }
                .onDelete(perform: deleteReview)
            }
            .navigationTitle("Book Reviews")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAdd = true
                    } label: {
                        Label("Add Review", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAdd) {
                AddReviewView() // You’ll need to create this
                    .environment(\.managedObjectContext, context)
            }
        }
    }

    private func deleteReview(at offsets: IndexSet) {
        for index in offsets {
            let review = reviews[index]
            ReviewManager.deleteReview(review, context: context)
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
