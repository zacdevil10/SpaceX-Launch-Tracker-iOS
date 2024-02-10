//
//  ArticleResponse.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 10/08/2023.
//

import Foundation

struct ArticleResponse : Identifiable {
    let id: Int
    let title: String
    let url: String
    let imageUrl: String
    let newsSite: String
    let summary: String
    let publishedAt: String
    let updatedAt: String
    let featured: Bool
    let launches: [Launch]
    
    struct Launch : Identifiable {
        let id: String
        let provider: String
    }
}

extension ArticleResponse: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case url
        case imageUrl = "image_url"
        case newsSite = "news_site"
        case summary
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
        case featured
        case launches
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let rawId = try? values.decode(Int.self, forKey: .id)
        let rawTitle = try? values.decode(String.self, forKey: .title)
        let rawUrl = try? values.decode(String.self, forKey: .url)
        let rawImageUrl = try? values.decode(String.self, forKey: .imageUrl)
        let rawNewsSite = try? values.decode(String.self, forKey: .newsSite)
        let rawSummary = try? values.decode(String.self, forKey: .summary)
        let rawPublishedAt = try? values.decode(String.self, forKey: .publishedAt)
        let rawUpdatedAt = try? values.decode(String.self, forKey: .updatedAt)
        let rawFeatured = try? values.decode(Bool.self, forKey: .featured)
        let rawLaunches = try? values.decode([Launch].self, forKey: .launches)
        
        guard let id = rawId,
              let title = rawTitle,
              let url = rawUrl,
              let imageUrl = rawImageUrl,
              let newsSite = rawNewsSite,
              let summary = rawSummary,
              let publishedAt = rawPublishedAt,
              let updatedAt = rawUpdatedAt,
              let featured = rawFeatured,
              let launches = rawLaunches
        else {
            throw NetworkError.missingData
        }
        
        self.id = id
        self.title = title
        self.url = url
        self.imageUrl = imageUrl
        self.newsSite = newsSite
        self.summary = summary
        self.publishedAt = publishedAt
        self.updatedAt = updatedAt
        self.featured = featured
        self.launches = launches
    }
}

extension ArticleResponse.Launch : Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "launch_id"
        case provider
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let rawId = try? values.decode(String.self, forKey: .id)
        let rawProvider = try? values.decode(String.self, forKey: .provider)
        
        guard let id = rawId,
              let provider = rawProvider
        else {
            throw NetworkError.missingData
        }
        
        self.id = id
        self.provider = provider
    }
}
