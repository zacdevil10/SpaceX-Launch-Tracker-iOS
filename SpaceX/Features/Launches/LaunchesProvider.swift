//
//  LaunchesProvider.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 11/08/2023.
//

import Foundation

class LaunchesProvider: ObservableObject {
    
    @Published var upcoming: ApiResult<[LaunchResponse]> = ApiResult.pending
    @Published var previous: [LaunchResponse] = [LaunchResponse]()
    
    let client: LaunchLibraryClient
    
    var previousNext: String? = nil
    
    func fetchUpcoming() async throws {
        let latestUpcoming = try await client.upcoming
        DispatchQueue.main.async {
            self.upcoming = ApiResult.success(latestUpcoming)
        }
    }
    
    func fetchPrevious() async throws {
        let latestPrevious = try await client.previous()

        previousNext = latestPrevious.next

        DispatchQueue.main.async {
            self.previous = latestPrevious.results
        }
    }
    
    func fetchPreviousNext(launch: LaunchResponse) async throws {
        let thresholdIndex = previous.last?.id
        if thresholdIndex == launch.id {
            let latestPrevious = try await client.previous(url: URL(string: previousNext!)!)
            
            previousNext = latestPrevious.next
            
            DispatchQueue.main.async {
                self.previous += latestPrevious.results
            }
        }
    }
    
    init (client: LaunchLibraryClient = LaunchLibraryClient()) {
        self.client = client
    }
}
