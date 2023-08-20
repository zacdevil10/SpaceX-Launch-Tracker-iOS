//
//  LaunchesProvider.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 11/08/2023.
//

import Foundation

class LaunchesProvider: ObservableObject {
    
    @Published var upcoming: ApiResult<[LaunchItem]> = ApiResult.pending
    @Published var previous: [LaunchItem] = [LaunchItem]()
    
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
            self.previous = latestPrevious.results.map { LaunchItem(response: $0) }
        }
    }
    
    func fetchPreviousNext(launch: LaunchItem) async throws {
        let thresholdIndex = previous.last?.id
        if thresholdIndex == launch.id {
            let latestPrevious = try await client.previous(url: URL(string: previousNext!)!)
            
            previousNext = latestPrevious.next
            
            DispatchQueue.main.async {
                self.previous += latestPrevious.results.map { LaunchItem(response: $0) }
            }
        }
    }
    
    init (client: LaunchLibraryClient = LaunchLibraryClient()) {
        self.client = client
    }
}
