//
//  Company.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 03/03/2024.
//

import Foundation

struct Company {
    let id: Int
    let name: String
    let description: String
    let administrator: String
    let foundingYear: String
    let totalLaunchCount: Int
    let website: String
    let wiki: String
    
    init(
        response: AgencyResponse
    ) {
        id = response.id
        name = response.name
        description = response.description
        administrator = response.administrator
        foundingYear = response.foundingYear
        totalLaunchCount = response.totalLaunchCount
        website = response.infoUrl
        wiki = response.wikiUrl
    }
    
    init(
        id: Int,
        name: String,
        description: String,
        administrator: String,
        foundingYear: String,
        totalLaunchCount: Int,
        website: String,
        wiki: String
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.administrator = administrator
        self.foundingYear = foundingYear
        self.totalLaunchCount = totalLaunchCount
        self.website = website
        self.wiki = wiki
    }
}
