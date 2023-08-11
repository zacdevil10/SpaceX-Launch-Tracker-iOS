//
//  SpaceflightNewsClient.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 10/08/2023.
//

import Foundation

class SpaceflightNewsClient {
    
    private let feedURL = URL(string: "https://api.spaceflightnewsapi.net/v4/articles/?search=SpaceX")!
    
    var articles: [ArticleResponse] {
        get async throws {
            let data = try await downloader.httpData(from: feedURL)
            let allArticles = try decoder.decode(SpaceflightNewsPaginatedResponse<ArticleResponse>.self, from: data)
            return allArticles.results
        }
    }
    
    private lazy var decoder: JSONDecoder = {
        let aDecoder = JSONDecoder()
        aDecoder.dateDecodingStrategy = .millisecondsSince1970
        return aDecoder
    }()
    
    private let downloader: any HTTPDataDownloader
    
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
}
