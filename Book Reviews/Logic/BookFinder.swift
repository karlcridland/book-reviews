//
//  BookFinder.swift
//  Book Reviews
//
//  Created by Karl Cridland on 18/06/2025.
//

import Foundation

class BookFinder {
    
    private static let base_url = "https://www.googleapis.com"
    
    static func search(by query: String) async throws -> [BookResult] {
        let query = "\(query)"
        let urlString = "\(base_url)/books/v1/volumes?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        let data = try await self.getData(from: urlString)
        let decoded = try JSONDecoder().decode(GoogleBooksResponse.self, from: data)
        return decoded.items?.filter({$0.isValid}) ?? []
    }
    
    static func book(by id: String) async throws -> BookResult? {
        let data = try await self.getData(from: "\(base_url)/books/v1/volumes/\(id)")
        let decoded = try JSONDecoder().decode(BookResult.self, from: data)
        return decoded
    }
    
    private static func getData(from urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
}

struct GoogleBooksResponse: Codable {
    let items: [BookResult]?
}

struct BookResult: Codable, Identifiable {
    let id: String
    let volumeInfo: VolumeInfo
    
    var hasAuthor: Bool {
        self.volumeInfo.authors?.count ?? 0 > 0
    }
    
    var hasImage: Bool {
        self.volumeInfo.imageUrl != nil
    }
    
    var isValid: Bool {
        return hasAuthor && hasImage
    }
    
    var authors: String {
        if let authors = self.volumeInfo.authors {
            return "By \(authors.joined(separator: ", "))"
        }
        return ""
    }
}

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]?
    let description: String?
    let imageLinks: ImageLinks?
    var imageUrl: String? {
        return self.imageLinks?.thumbnail?.replacing("http://", with: "https://")
    }
}

struct ImageLinks: Codable {
    let thumbnail: String?
}
