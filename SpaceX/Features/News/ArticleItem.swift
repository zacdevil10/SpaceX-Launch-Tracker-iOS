//
//  DomainObjects.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 10/02/2024.
//

import Foundation

struct ArticleItem : Identifiable {
    let id: Int
    let title: String
    let image: String
    let url: String
    let site: String
    let published: String?
    
    init(
        response: ArticleResponse
    ) {
        self.id = response.id
        self.title = response.title
        self.image = response.imageUrl
        self.url = response.url
        self.site = response.newsSite
        self.published = response.publishedAt
    }
}
