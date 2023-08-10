//
//  LaunchLibraryPaginatedResponse.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 10/08/2023.
//

import Foundation

struct LaunchLibraryPaginatedResponse<T : Decodable> : Decodable {
    
    private enum RootCodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
        case detail
    }
    
    private(set) var count: Int? = nil
    private(set) var next: String? = nil
    private(set) var previous: String? = nil
    private(set) var results: [T] = []
    private(set) var detail: String? = nil
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        var resultsContainer = try rootContainer.nestedUnkeyedContainer(forKey: .results)
        
        if let count = try? rootContainer.decode(Int?.self, forKey: .count) {
            self.count = count
        }
        
        if let next = try? rootContainer.decode(String?.self, forKey: .next) {
            self.next = next
        }
        
        if let previous = try? rootContainer.decode(String?.self, forKey: .previous) {
            self.previous = previous
        }
        
        while !resultsContainer.isAtEnd {
            if let result = try? resultsContainer.decode(T.self) {
                results.append(result)
            }
        }
        
        if let detail = try? rootContainer.decode(String?.self, forKey: .detail) {
            self.detail = detail
        }
    }
}
