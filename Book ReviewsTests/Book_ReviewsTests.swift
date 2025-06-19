//
//  Book_ReviewsTests.swift
//  Book ReviewsTests
//
//  Created by Karl Cridland on 18/06/2025.
//

import Testing
@testable import Book_Reviews

struct Book_ReviewsTests {

    @Test func searchFeature() async throws {
        let results = try await BookFinder.search(by: "fourth wing")
        results.forEach { result in
            let authors = result.volumeInfo.authors ?? []
            print(result.volumeInfo.title, authors.joined(separator: ", "), result.id) //E-OLEAAAQBAJ
        }
        #expect(results.count > 0)
    }
    
    @Test func bookByID() async throws {
        let result = try await BookFinder.book(by: "E-OLEAAAQBAJ")
        #expect(result != nil)
    }
    
}
