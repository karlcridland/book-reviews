//
//  SearchBar.swift
//  Book Reviews
//
//  Created by Karl Cridland on 19/06/2025.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSubmit: () async -> Void

    @FocusState private var isFocused: Bool

    var body: some View {
        TextField("Search", text: $text)
            .textFieldStyle(.plain)
            .padding(14)
            .font(.title3)
            .fontWeight(.medium)
            .focused($isFocused)
            .submitLabel(.search)
            .background(.white)
            .cornerRadius(16)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .shadow(color: Color.primary.opacity(0.1), radius: 8)
            .onSubmit {
                Task { await onSubmit() }
            }
            .onChange(of: text, initial: false) { _, _ in
                Task { await onSubmit() }
            }
            .task {
                isFocused = true
            }
    }
}
