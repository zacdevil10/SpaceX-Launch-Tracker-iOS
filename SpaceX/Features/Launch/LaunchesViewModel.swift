//
//  LaunchesProvider.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 11/08/2023.
//

import Foundation

class LaunchesViewModel: ObservableObject {
    
    @Published var upcoming: ApiResult<[LaunchItem]> = ApiResult.pending
    @Published var previous: ApiResult<[LaunchItem]> = ApiResult.pending
    
    var previousLoadState: LoadState = LoadState.pending
    
    let client: LaunchLibraryClient
    
    init (client: LaunchLibraryClient = LaunchLibraryClient()) {
        self.client = client
        
        self.client.getUpcomingLaunches() { result in
            self.upcoming = result.transform { value in value.map { LaunchItem(response: $0) } }
        }
        
        self.client.getPreviousLaunches() { result in
            self.previous = result.transform { value in value.map { LaunchItem(response: $0) } }
        }
    }
    
    func fetchPreviousNext(id: String) async {
        previousLoadState = LoadState.pending
        if case .success(let data) = previous {
            let thresholdIndex = data.last?.id
            if thresholdIndex == id {
                client.getPreviousLaunches() { result in
                    self.previous = result.transform { value in data + value.map { LaunchItem(response: $0) }}
                }
            } else {
                previousLoadState = LoadState.success
            }
        }
    }
}
