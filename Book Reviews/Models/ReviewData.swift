//
//  ReviewData.swift
//  Book Reviews
//
//  Created by Karl Cridland on 18/06/2025.
//

import CoreData

struct ReviewData: Codable {
    
    var bookID: String
    var body: String
    var rating: Int
    
    func toReview(context: NSManagedObjectContext) -> Review {
        let review = Review(context: context)
        review.body = body
        review.rating = Int16(rating)
        if let book = self.getBook() {
            review.book = book
        }
        return review
    }
    
    func getBook() -> Book? {
        Library.shared.getBook(by: self.bookID)
    }
    
}
