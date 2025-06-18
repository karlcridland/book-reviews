//
//  AuthorManager.swift
//  Book Reviews
//
//  Created by Karl Cridland on 18/06/2025.
//

class AuthorManager {
    
    public static let shared = AuthorManager()
    
    var items: [Author] = []
    
    private init() {
        
    }
    
    func get(_ name: String?) -> Author? {
        return self.items.first(where: {$0.name == name})
    }
    
}
