//
//  ArticlesViewModel.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 10/02/2024.
//

import Foundation

class ArticlesViewModel: ObservableObject {
    
    @Published var articles: ApiResult<[ArticleItem]> = ApiResult.pending
    
    var articlesLoadState: LoadState = LoadState.pending
    
    let client: SpaceflightNewsClient
    
    init(client: SpaceflightNewsClient = SpaceflightNewsClient()) {
        self.client = client
        
        self.client.getArticles() { result in
            self.articles = result.transform { value in value.map { ArticleItem(response: $0) }}
        }
    }
    
    func fetchNextArticles(id: Int) async {
        articlesLoadState = LoadState.pending
        if case .success(let data) = articles {
            let thresholdIndex = data.last?.id
            if thresholdIndex == id {
                client.getArticles() { result in
                    self.articles = result.transform { value in data + value.map { ArticleItem(response: $0) }}
                }
            } else {
                articlesLoadState = LoadState.success
            }
        }
    }
}
