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
        sortDescriptors: [NSSortDescriptor(keyPath: \Review.reviewed, ascending: false)]
    ) private var reviews: FetchedResults<Review>
    
    @State private var showingAdd = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack {
                    List {
                        ForEach(reviews) { review in
                            HStack(spacing: 15) {
                                BookImage(urlString: review.book?.imageURL ?? "")
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack(alignment: .bottom) {
                                        Text(review.book?.title ?? "Unknown Book")
                                        Spacer()
//                                        Text(Int(review.rating).stars)
                                    }
                                    .font(.headline)

                                    Text(review.body ?? "No review.")
                                        .font(.subheadline)
                                }
                                .padding(.vertical, 12)
                            }
                            .background(Color.white)
                        }
                        .onDelete(perform: deleteReview)
                    }
                    .scrollContentBackground(.hidden)
                    .contentMargins(10)
                }
                
                ZStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 1) {
                            ForEach(uniqueBooks) { book in
                                BookChip(book: book)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    HStack {
                        Spacer()
                        Button {
                            showingAdd = true
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(.charcoal)
                                .frame(width: 50, height: 50)
                                .background(Color(.frost))
                                .cornerRadius(12)
                                .shadow(color: Color.charcoal.opacity(0.2), radius: 8)
                        }
                        .padding(.trailing, 16)
                    }
                }
                .frame(height: 120)
                
                Rectangle()
                    .frame(height: 3)
                    .background(Color.brown)
                
                Spacer()
                
            }
            .navigationTitle("Book Reviews")
            .background(Color(.background))
            .navigationDestination(isPresented: $showingAdd) {
                AddReviewView()
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
    
    private var uniqueBooks: [Book] {
        var seen = Set<NSManagedObjectID>()
        return reviews.sorted(by: {$0.finished ?? .now < $1.finished ?? .now}).compactMap { $0.book }
            .filter { seen.insert($0.objectID).inserted }
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

struct BookChip: View {
    let book: Book

    var text: String {
        if let title = book.title {
            return "\(title)"
        }
        return book.title ?? ""
    }

    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 2)
                .fill(BookColorManager.getColor())
                .frame(width: 30, height: 120)
                .overlay(
                    Text(text)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(90))
                        .transformEffect(CGAffineTransform(translationX: 0, y: 5))
                        .frame(width: 110, height: 30)
                )

            Rectangle()
                .fill(Color.yellow.opacity(0.2))
                .frame(width: 30, height: 2)
                .transformEffect(CGAffineTransform(translationX: 0, y: 5))
        }
    }
}

class BookColorManager {
    
    private static let colors: [Color] = [.bookRed, .bookGold, .bookGreen, .bookBlue]
    private static var lastUsed: Color?
    private static var count: Int = 0
    
    static func getColor() -> Color {
        let color = self.colors[(fibonacci(count)) % self.colors.count]
//        let color = self.colors.filter({$0 != lastUsed}).randomElement() ?? .bookBlue
        self.lastUsed = color
        count += 1
        return color
    }
    
    static func fibonacci(_ n: Int) -> Int {
        guard n > 1 else {
            return n
        }
        return fibonacci(n - 1) + fibonacci(n - 2)
    }
    
}
