//
//  BookImage.swift
//  Book Reviews
//
//  Created by Karl Cridland on 19/06/2025.
//

import SwiftUI

struct BookImage: View {
    let urlString: String?
    var width: CGFloat = 30
    var height: CGFloat = 45

    var body: some View {
        if let urlString = urlString,
           let secureURL = secureURL(from: urlString),
           let url = URL(string: secureURL) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    placeholder
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: width, height: height)
                        .cornerRadius(6)
                case .failure:
                    placeholder
                @unknown default:
                    placeholder
                }
            }
        } else {
            placeholder
        }
    }

    private var placeholder: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: width, height: height)
                .cornerRadius(6)

            Image(systemName: "questionmark")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
        }
        .frame(width: width, height: height)
    }

    private func secureURL(from original: String) -> String? {
        guard !original.isEmpty else { return nil }
        return original.replacingOccurrences(of: "http://", with: "https://")
    }
}
