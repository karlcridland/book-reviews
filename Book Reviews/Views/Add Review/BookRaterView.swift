//
//  BookRaterView.swift
//  Book Reviews
//
//  Created by Karl Cridland on 20/06/2025.
//

import SwiftUI

struct BookRaterView: View {
    
    @Binding var score: Int
    @Binding var selectedBook: BookResult?

    var title: String
    var debug = false

    var body: some View {
        Section {
            GeometryReader { geo in
                ZStack(alignment: .topLeading) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .foregroundColor(.charcoal)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .transformEffect(CGAffineTransform(translationX: 0, y: -6))
                        
                        ZStack {
                            HStack(spacing: 12) {
                                ForEach(1...5, id: \.self) { i in
                                    VStack {
                                        Spacer(minLength: 0)

                                        Rectangle()
                                            .fill(score >= i ? Color(.olive) : Color.gray.opacity(0.4))
                                            .frame(height: 4 + CGFloat(score >= i ? (i * 2) : 0), alignment: .bottom)
                                            .cornerRadius(2)
                                            .animation(.easeInOut(duration: 0.25), value: score)
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        score = i
                                    }
                                }
                            }
                        }
                        .frame(height: 16)
                        .transformEffect(CGAffineTransform(translationX: 0, y: -8))
                    }
                    .padding(.vertical, 10)
                    
                    Color.clear
                        .contentShape(Rectangle())
                        .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onEnded { value in
                                    let widthPerSegment = geo.size.width / 5
                                    let x = max(0, min(value.location.x, geo.size.width))
                                    let index = Int(x / widthPerSegment) + 1
                                    score = min(max(index, 1), 5)
                                }
                        )
                }
            }
            .frame(height: 42)
        }
        .listRowBackground(Color.white.opacity(selected ? 1 : 0.6))
        .disabled(!selected)
        .opacity(selected ? 1 : 0.6)
    }

    private var selected: Bool {
        selectedBook != nil
    }
}
