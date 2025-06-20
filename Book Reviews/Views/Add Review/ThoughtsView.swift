//
//  ThoughtsView.swift
//  Book Reviews
//
//  Created by Karl Cridland on 20/06/2025.
//

import SwiftUI

struct ThoughtsView: View {
    
    @Binding var review: String
    @Binding var selectedBook: BookResult?

    var body: some View {
        Section {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Your thoughts:")
                        .foregroundColor(.charcoal)
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
        .listRowBackground(Color.white.opacity(selected ? 1 : 0.6))
        .disabled(!selected)
        .opacity(selected ? 1 : 0.6)
        .padding(.bottom, 16)
    }
    
    var selected: Bool {
        return selectedBook != nil
    }
    
}
