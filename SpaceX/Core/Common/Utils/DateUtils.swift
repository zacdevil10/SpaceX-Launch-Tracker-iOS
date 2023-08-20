//
//  DateUtils.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 11/08/2023.
//

import Foundation

extension String {
    
    func formatLaunchDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let date = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "dd MMM yy - HH:mm"
        
        return dateFormatter.string(from: date ?? Date())
    }
    
    func formatLaunchDateToMillis() -> Int64? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let date = dateFormatter.date(from: self)
        return Int64((date!.timeIntervalSince1970 * 1000).rounded())
    }
    
    func formatCrewDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let date = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "dd MMM yy"
        
        return dateFormatter.string(from: date ?? Date())
    }
}
