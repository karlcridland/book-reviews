//
//  DatePickerView.swift
//  Book Reviews
//
//  Created by Karl Cridland on 20/06/2025.
//

import SwiftUI

struct DatePickerView: View {
    
    @Binding var startDate: Date
    @Binding var finishDate: Date
    @Binding var selectedBook: BookResult?

    @State private var showStartPicker = false
    @State private var showFinishPicker = false
    
    var debug: Bool = false

    var body: some View {
        Section {
            VStack(alignment: .leading, spacing: 4) {
                Text("Dates")
                    .foregroundColor(.charcoal)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical, 10)
                
                HStack {
                    Text("Started on:")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                        .frame(width: 100, alignment: .leading)
                    
                    Spacer()

                    DatePicker("", selection: $startDate, displayedComponents: .date)
                        .labelsHidden()
                }
                .padding(.bottom, 12)
                
                HStack {
                    Text("Finished on:")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                        .frame(width: 100, alignment: .leading)
                    
                    Spacer()

                    DatePicker("", selection: $finishDate, displayedComponents: .date)
                        .labelsHidden()
                }
                .padding(.bottom, 12)
                
            }
        }
        .listRowBackground(Color.white.opacity(selected ? 1 : 0.6))
        .disabled(!selected)
        .opacity(selected ? 1 : 0.6)
    }

    var selected: Bool {
        return (selectedBook != nil || debug)
    }
}
