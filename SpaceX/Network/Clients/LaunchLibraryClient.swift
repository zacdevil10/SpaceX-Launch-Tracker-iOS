//
//  LaunchLibraryClient.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 10/08/2023.
//

import Foundation

class LaunchLibraryClient {
    
    private let upcomingUrl = URL(string: "https://lldev.thespacedevs.com/2.2.0/launch/upcoming?limit=10&search=SpaceX&mode=detailed")!
    
    var upcoming: [LaunchResponse] {
        get async throws {
            let data = try await downloader.httpData(from: upcomingUrl)
            let upcomingLaunches = try decoder.decode(LaunchLibraryPaginatedResponse<LaunchResponse>.self, from: data)
            return upcomingLaunches.results
        }
    }
    
    private let previousUrl = URL(string: "https://lldev.thespacedevs.com/2.2.0/launch/previous?search=SpaceX&mode=detailed")!
    
    func previous(url: URL = URL(string: "https://lldev.thespacedevs.com/2.2.0/launch/previous?search=SpaceX&mode=detailed")!) async throws -> LaunchLibraryPaginatedResponse<LaunchResponse> {
        let data = try await downloader.httpData(from: url)
        let previousLaunches = try decoder.decode(LaunchLibraryPaginatedResponse<LaunchResponse>.self, from: data)
        return previousLaunches
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
