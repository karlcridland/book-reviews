//
//  Library.swift
//  Book Reviews
//
//  Created by Karl Cridland on 18/06/2025.
//

class Library {
    
    public static let shared = Library()
    
    private var books: [Book] = []
    
    private init() {
        
    }
    
    func getBook(by id: String) -> Book? {
        return self.books.first(where: {$0.id == id})
    }
    
}
