//
//  Source.swift
//  NewsAPI
//
//  Created by iOS Dev Log on 2018/3/1.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

import Foundation

class Source: NSObject, Codable {
    let id: String
    let name: String
    let desc: String
    let url: String
    let category: String
    let language: String
    let country: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc = "description"
        case url
        case category
        case language
        case country
    }
    
    init(id: String,
         name: String,
         desc: String,
         url: String,
         category: String,
         language: String,
         country: String) {
        self.id = id
        self.name = name
        self.desc = desc
        self.url = url
        self.category = category
        self.language = language
        self.country = country
    }
}
