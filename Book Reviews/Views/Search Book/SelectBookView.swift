//
//  SelectBookView.swift
//  Book Reviews
//
//  Created by Karl Cridland on 19/06/2025.
//

import SwiftUI

struct SelectBookView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var query = ""
    @State private var results: [BookResult] = []
    @State private var isLoading = false
    
    @State private var type_count: Int = 0
    
    @FocusState private var isSearchFocused: Bool
    
    var onBookSelected: (BookResult) -> Void
    
    var body: some View {
        ZStack {
            VStack (spacing: 0, content: {
                SearchBar(text: $query) {
                    await search()
                }
                
                List(results, id: \.id) { book in
                    Button {
                        onBookSelected(book)
                        dismiss()
                    } label: {
                        HStack(alignment: .top, spacing: 16) {
                            BookImage(urlString: book.volumeInfo.imageUrl)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(book.volumeInfo.title)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                if let authors = book.volumeInfo.authors {
                                    Text(authors.joined(separator: ", "))
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            
                            Spacer()
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.automatic)
            })
        }
        .background(Color.background)
    }
    
    private func search() async {
        type_count += 1
        let current_type_count = type_count
        try? await Task.sleep(nanoseconds: 200_000_000)
        if (type_count != current_type_count) {
            return
        }
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            results = []
            return
        }
        
        isLoading = true
        do {
            let books = try await BookFinder.search(by: query)
            results = books
        } catch {
            print("Search failed: \(error)")
            results = []
        }
        isLoading = false
    }
    
}

#Preview {
    SelectBookView(onBookSelected: { book in
        print(book)
    }).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
