//
//  LaunchesProvider.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 11/08/2023.
//

import Foundation

class LaunchesProvider: ObservableObject {
    
    @Published var upcoming: ApiResult<[LaunchResponse]> = ApiResult.pending
    @Published var previous: ApiResult<[LaunchResponse]> = ApiResult.pending
    
    let client: LaunchLibraryClient
    
    func fetchUpcoming() async throws {
        let latestUpcoming = try await client.upcoming
        DispatchQueue.main.async {
            self.upcoming = ApiResult.success(latestUpcoming)
        }
    }
    
    func fetchPrevious() async throws {
        let latestPrevious = try await client.previous
        DispatchQueue.main.async {
            self.previous = ApiResult.success(latestPrevious)
        }
    }
    
    init (client: LaunchLibraryClient = LaunchLibraryClient()) {
        self.client = client
    }
}
