//
//  LaunchLibraryClient.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 10/08/2023.
//

import Foundation

class LaunchLibraryClient {
    
    let baseUrl: String = "https://lldev.thespacedevs.com/2.2.0/"

    var previousNext: String? = nil
    
    func getUpcomingLaunches(handler: @escaping (ApiResult<[LaunchResponse]>) -> Void) {
        downloader.get(
            url: "\(baseUrl)launch/upcoming?limit=10&search=SpaceX&mode=detailed",
            model: LaunchLibraryPaginatedResponse<LaunchResponse>.self
        ) { result in
            handler(result.transform { value in value.results})
        }
    }
    
    func getPreviousLaunches(
        url: String = "launch/previous?search=SpaceX&mode=detailed",
        handler: @escaping (ApiResult<[LaunchResponse]>) -> Void
    ) {
        // Bug: Once at end of list, previousNext will be null which means url will be used instead of not making a request.
        downloader.get(
            url: previousNext ?? "\(baseUrl)\(url)",
            model: LaunchLibraryPaginatedResponse<LaunchResponse>.self
        ) { result in
            handler(
                result.transform { value in
                    self.previousNext = value.next
                    return value.results
                }
            )
        }
    }
    
    func getAgency(handler: @escaping (ApiResult<AgencyResponse>) -> Void) {
        downloader.get(url: "\(baseUrl)agencies/121?mode=detailed", model: AgencyResponse.self) { result in
            handler(result)
        }
    }
    
    private let downloader: any HTTPDataDownloader
    
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
}
