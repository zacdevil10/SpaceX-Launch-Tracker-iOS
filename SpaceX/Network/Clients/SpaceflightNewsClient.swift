//
//  SpaceflightNewsClient.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 10/08/2023.
//

import Foundation

class SpaceflightNewsClient {
    
    private let feedURL = "https://api.spaceflightnewsapi.net/v4/articles/?search=SpaceX"
    private var nextUrl: String? = nil

    func getArticles(handler: @escaping (ApiResult<[ArticleResponse]>) -> Void) {
        // Bug: Once at end of list, nextUrl will be null which means feedURL will be used instead of not making a request.
        downloader.get(
            url: nextUrl ?? feedURL,
            model: SpaceflightNewsPaginatedResponse<ArticleResponse>.self
        ) { result in
            handler(
                result.transform { value in
                    self.nextUrl = value.next
                    return value.results
                }
            )
        }
    }

    private let downloader: any HTTPDataDownloader
    
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
}
