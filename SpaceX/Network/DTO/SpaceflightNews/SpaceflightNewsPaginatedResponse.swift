//
//  SpaceflightNewsPaginatedResponse.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 10/08/2023.
//

import Foundation

struct SpaceflightNewsPaginatedResponse<T : Decodable> : Decodable {
    
    private(set) var count: Int? = nil
    private(set) var next: String? = nil
    private(set) var previous: String? = nil
    private(set) var results: [T] = []
    
    private enum CodingKeys : CodingKey {
        case count
        case next
        case previous
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decodeIfPresent(Int.self, forKey: .count)
        self.next = try container.decodeIfPresent(String.self, forKey: .next)
        self.previous = try container.decodeIfPresent(String.self, forKey: .previous)
        self.results = try container.decode([T].self, forKey: .results)
    }
}
