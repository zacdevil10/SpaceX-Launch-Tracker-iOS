//
//  LaunchesProvider.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 11/08/2023.
//

import Foundation

class LaunchesProvider: ObservableObject {
    
    @Published var upcoming: ApiResult<[LaunchItem]> = ApiResult.pending
    @Published var previous: ApiResult<[LaunchItem]> = ApiResult.pending
    
    var previousLoadState: LoadState = LoadState.pending
    
    let client: LaunchLibraryClient
    
    var previousNext: String? = nil
    
    func fetchUpcoming() async throws {
        let latestUpcoming = try await client.upcoming
        DispatchQueue.main.async {
            self.upcoming = ApiResult.success(latestUpcoming.map { LaunchItem(response: $0) })
        }
    }
    
    func fetchPrevious() async throws {
        let latestPrevious = try await client.previous()

        previousNext = latestPrevious.next

        DispatchQueue.main.async {
            self.previous = ApiResult.success(latestPrevious.results.map { LaunchItem(response: $0) })
        }
    }
    
    func fetchPreviousNext(launch: LaunchItem) async throws {
        previousLoadState = LoadState.pending
        if case .success(let data) = previous {
            if let next = previousNext {
                let thresholdIndex = data.last?.id
                if thresholdIndex == launch.id {
                    let latestPrevious = try await client.previous(url: URL(string: next)!)
                    
                    previousNext = latestPrevious.next
                    
                    DispatchQueue.main.async {
                        self.previous = ApiResult.success(data + latestPrevious.results.map { LaunchItem(response: $0) })
                    }
                    
                    if self.previousNext == nil {
                        self.previousLoadState = LoadState.success
                    }
                }
            } else {
                previousLoadState = LoadState.success
            }
        }
    }
    
    init (client: LaunchLibraryClient = LaunchLibraryClient()) {
        self.client = client
    }
}
