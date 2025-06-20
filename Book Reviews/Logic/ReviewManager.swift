//
//  ReviewManager.swift
//  Book Reviews
//
//  Created by Karl Cridland on 18/06/2025.
//

import Foundation
import CoreData

class ReviewManager {
    
    static func addReview(body: String, ratings: ReviewRatings, start: Date, finish: Date, book: Book, context: NSManagedObjectContext) {
        
        let newReview = Review(context: context)
        newReview.body = body
        newReview.score_plot = ratings.plot
        newReview.score_pacing = ratings.pacing
        newReview.score_writing_style = ratings.writingStyle
        newReview.score_world_building = ratings.worldBuilding
        newReview.score_character_development = ratings.characterDevelopment
        newReview.book = book
        newReview.reviewed = Date()
        newReview.started = start
        newReview.finished = finish
        
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

struct ReviewRatings {
    let plot, pacing, writingStyle, worldBuilding, characterDevelopment: Int16
}
