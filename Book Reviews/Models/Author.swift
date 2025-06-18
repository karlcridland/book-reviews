//
//  Author.swift
//  Book Reviews
//
//  Created by Karl Cridland on 18/06/2025.
//

import Foundation

struct Author: Codable, Equatable {
    
    let id: String
    let first: String
    let last: String
    
    init(_ first: String, _ last: String) {
        self.id = UUID().uuidString
        self.first = first
        self.last = last
    }
    
    init(_ id: String, _ first: String, _ last: String) {
        self.id = id
        self.first = first
        self.last = last
    }
    
    static func ==(lhs: Author, rhs: Author) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func !=(lhs: Author, rhs: Author) -> Bool {
        return !(lhs.id == rhs.id)
    }
    
    var name: String {
        return "\(first) \(last)"
    }
    
}
