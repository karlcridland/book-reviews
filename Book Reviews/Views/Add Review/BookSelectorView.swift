//
//  BookSelectorView.swift
//  Book Reviews
//
//  Created by Karl Cridland on 20/06/2025.
//

import SwiftUI

struct BookSelectorView: View {
    
    @Binding var showingSelectBook: Bool
    @Binding var selectedBook: BookResult?
    
    var body: some View {
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
                        .foregroundColor(selected ? .olive : .secondary)
                })
            }
        }
        .listRowBackground(Color.frost)
    }
    
    var selected: Bool {
        return selectedBook != nil
    }
    
}
