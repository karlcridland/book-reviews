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
            VStack {
                List {
                    ForEach(reviews) { review in
                        HStack (spacing: 15, content: {
                            BookImage(urlString: review.book?.imageURL ?? "")
                            VStack(alignment: .leading, spacing: 8) {
                                HStack(alignment: .bottom) {
                                    Text(review.book?.title ?? "Unknown Book")
                                    Spacer()
                                    Text(Int(review.rating).stars)
                                }
                                .font(.headline)
                                
                                Text(review.body ?? "No review.")
                                    .font(.subheadline)
                            }
                            .padding(.vertical, 12)
                        })
                        .background(Color(.white))
                    }
                    .onDelete(perform: deleteReview)
                }
                .scrollContentBackground(.hidden)
                .contentMargins(10)
                .navigationTitle("Book Reviews")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAdd = true
                        } label: {
                            Label("Add Review", systemImage: "plus.app.fill").fontWeight(.medium)
                        }
                    }
                }
                .navigationDestination(isPresented: $showingAdd) {
                    AddReviewView()
                        .environment(\.managedObjectContext, context)
                }
                Spacer()
                
            }
            .background(Color(.background))
        }
    }
    
    private func deleteReview(at offsets: IndexSet) {
        for index in offsets {
            let review = reviews[index]
            ReviewManager.deleteReview(review, context: context)
        }
    }
}

extension Int {
    var stars: String {
        String(repeating: "⭐️", count: self)
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
