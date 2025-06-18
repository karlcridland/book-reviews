//
//  ReviewManager.swift
//  Book Reviews
//
//  Created by Karl Cridland on 18/06/2025.
//

import Foundation
import CoreData

class ReviewManager {
    
    static func addReview(body: String, rating: Int16, book: Book, context: NSManagedObjectContext) {
        
        let newReview = Review(context: context)
        newReview.body = body
        newReview.rating = rating
        newReview.book = book
        newReview.date = Date() // Add this attribute to sort later if needed
        
        do {
            try context.save()
        } catch {
            print("Failed to save review: \(error.localizedDescription)")
        }
    }

    static func deleteReview(_ review: Review, context: NSManagedObjectContext) {
        context.delete(review)
        do {
            try context.save()
        } catch {
            print("Failed to delete review: \(error.localizedDescription)")
        }
    }
    
}
