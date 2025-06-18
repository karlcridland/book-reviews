//
//  Book.swift
//  Book Reviews
//
//  Created by Karl Cridland on 18/06/2025.
//

import CoreData

//@objc(Book)
//class Book: NSManagedObject {
//    
//    @NSManaged var isbn: String
//    @NSManaged var title: String
//    @NSManaged var authorName: String  // Flattened version of author
//    @NSManaged var pages: Int16
//    @NSManaged var genreStrings: [String]    // Or a custom transformable type
//    
//    var genre: [Genre] {
//        return genreStrings.compactMap { Genre(rawValue: $0) }
//    }
//    
//    var author: Author? {
//        return AuthorManager.shared.get(authorName)
//    }
//    
//}

extension Book {
    
    var genre: [Genre] {
        if let data = genreStrings as? [String] {
            return data.compactMap { Genre(rawValue: $0) }
        }
        return []
    }

    var author: Author? {
        return AuthorManager.shared.get(authorName)
    }
    
}

enum Genre: String {
    case romance = "Romance"
    case fantasy = "Fantasy"
    case sci_fi = "Sci-Fi"
    case horror = "Horror"
    case mystery = "Mystery"
    case thriller = "Thriller"
    case crime = "Crime"
}
