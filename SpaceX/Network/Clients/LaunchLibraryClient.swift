//
//  LaunchLibraryClient.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 10/08/2023.
//

import Foundation

class LaunchLibraryClient {
    
    private let upcomingUrl = URL(string: "https://ll.thespacedevs.com/2.2.0/launch/upcoming?limit=10&search=SpaceX&mode=detailed")!
    
    var upcoming: [LaunchResponse] {
        get async throws {
            let data = try await downloader.httpData(from: upcomingUrl)
            let upcomingLaunches = try decoder.decode(LaunchLibraryPaginatedResponse<LaunchResponse>.self, from: data)
            return upcomingLaunches.results
        }
    }
    
    private let previousUrl = URL(string: "https://ll.thespacedevs.com/2.2.0/launch/previous?search=SpaceX&mode=detailed")!
    
    var previous: [LaunchResponse] {
        get async throws {
            let data = try await downloader.httpData(from: previousUrl)
            let previousLaunches = try decoder.decode(LaunchLibraryPaginatedResponse<LaunchResponse>.self, from: data)
            return previousLaunches.results
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
