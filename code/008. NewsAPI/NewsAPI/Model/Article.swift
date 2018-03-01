//
//  Article.swift
//  NewsAPI
//
//  Created by iOS Dev Log on 2018/3/1.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

import Foundation
class Article: NSObject, Codable {
    let author: String?
    let title: String
    let snippet: String
    let sourceURL: URL
    let imageURL: URL
    let published: Date?
    
    enum CodingKeys: String, CodingKey {
        case author
        case title
        case snippet = "description"
        case sourceURL = "url"
        case imageURL = "urlToImage"
        case published = "publishedAt"
    }
    
    init(author: String, title: String, snippet: String, sourceURL: URL, imageURL: URL, published: Date) {
        self.author = author
        self.title = title
        self.snippet = snippet
        self.sourceURL = sourceURL
        self.imageURL = imageURL
        self.published = published
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        author = try container.decodeIfPresent(String.self, forKey: .author)
        title = try container.decode(String.self, forKey: .title)
        let rawSnippet = try container.decode(String.self, forKey: .snippet)
        snippet = rawSnippet.deletingCharacters(in: CharacterSet.newlines)
        sourceURL = try container.decode(URL.self, forKey: .sourceURL)
        imageURL = try container.decode(URL.self, forKey: .imageURL)
        published = try container.decodeIfPresent(Date.self, forKey: .published)
    }
}

extension String {
    func deletingCharacters(in characters: CharacterSet) -> String {
        return self.components(separatedBy: characters).filter { !$0.isEmpty }.joined(separator: " ")
    }
    
    mutating func deleteMillisecondsIfPresent(){
        if count == 24 {
            let range = index(endIndex, offsetBy: -5)..<index(endIndex, offsetBy: -1)
            removeSubrange(range)
        }
    }
}
