//
//  NewsAPI.swift
//  NewsAPI
//
//  Created by iOS Dev Log on 2018/3/1.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

import Foundation

class NewsAPI: NSObject {
    
    static let service = NewsAPI()
    
    @objc dynamic private(set) var sources: [Source] = []
    @objc dynamic private(set) var articles: [Article] = []
    
    private struct Response: Codable {
        let sources: [Source]?
        let articles: [Article]?
    }
    
    private enum API {
        private static let basePath = "https://newsapi.org/v1"
        /*
         Head on over to https://newsapi.org/register to get your
         free API key, and then replace the value below with it.
         */
        private static let key = "ca58b38a0d4540568139e3ce0657594d"
        
        case sources
        case articles(Source)
        
        func fetch(completion: @escaping (Data) -> ()) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: path()) { (data, response, error) in
                guard let data = data, error == nil else { return }
                completion(data)
            }
            task.resume()
        }
        
        private func path() -> URL {
            switch self {
            case .sources:
                return URL(string: "\(API.basePath)/sources")!
            case .articles(let source):
                return URL(string: "\(API.basePath)/articles?source=\(source.id)&apiKey=\(API.key)")!
            }
        }
    }
    
    func fetchSources() {
        API.sources.fetch { data in
            if let sources = try! JSONDecoder().decode(Response.self, from: data).sources {
                self.sources = sources
            }
        }
    }
    
    func fetchArticles(for source: Source) {
        let customDateHandler: (Decoder) throws -> Date = { decoder in
            var string = try decoder.singleValueContainer().decode(String.self)
            string.deleteMillisecondsIfPresent()
            if #available(iOS 10.0, *) {
                let formatter = ISO8601DateFormatter()
                guard let date = formatter.date(from: string) else { return Date() }
                
                return date
            } else {
                return Date()
            }
        }
        API.articles(source).fetch { data in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom(customDateHandler)
            if let articles = try? decoder.decode(Response.self, from: data).articles {
                self.articles = articles!
            }
        }
    }
    
    func resetArticles() {
        articles = []
    }
}
