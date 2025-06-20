//
//  ReviewData.swift
//  Book Reviews
//
//  Created by Karl Cridland on 18/06/2025.
//

import CoreData

extension Review {
    
    var rating: String {
        return "A+"
    }
    
}

//struct ReviewData: Codable {
//    
//    var bookID: String
//    var body: String
//    var ratings: [String: Int16]
//    
//    func toReview(context: NSManagedObjectContext) -> Review {
//        let review = Review(context: context)
//        review.body = body
//        review.score_plot = Int16(ratings["_plot"] ?? 0)
//        review.score_pacing = Int16(ratings["_pacing"] ?? 0)
//        review.score_writing_style = Int16(ratings["_writing_style"] ?? 0)
//        review.score_world_building = Int16(ratings["_world_building"] ?? 0)
//        review.score_character_development = Int16(ratings["_character_development"] ?? 0)
//        if let book = self.getBook() {
//            review.book = book
//        }
//        return review
//    }
//    
//    func getBook() -> Book? {
//        Library.shared.getBook(by: self.bookID)
//    }
//    
//}
