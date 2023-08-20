//
//  CollectionUtils.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 20/08/2023.
//

import Foundation

extension Collection {
    
    func groupBy<Key: Hashable>(by keyClosure: (Element) -> Key) -> [Key: [Element]] {
            var groupedDictionary = [Key: [Element]]()
            
            for element in self {
                let key = keyClosure(element)
                if groupedDictionary[key] == nil {
                    groupedDictionary[key] = [element]
                } else {
                    groupedDictionary[key]?.append(element)
                }
            }
            
            return groupedDictionary
        }
}
