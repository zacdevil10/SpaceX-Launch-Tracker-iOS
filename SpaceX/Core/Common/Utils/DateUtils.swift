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
    
    func formatLaunchDateToMillis() -> Double? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: self) {
            let milliseconds = date.timeIntervalSince1970 * 1000
            return milliseconds
        }
        
        return nil
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

extension TimeInterval {
    var daysHoursMinutesSeconds: String {
        let timeDifferenceInMillis = self

        let days = Int64(timeDifferenceInMillis / (1000 * 60 * 60 * 24))
        let hours = Int64((timeDifferenceInMillis / (1000 * 60 * 60)).truncatingRemainder(dividingBy: 24))
        let minutes = Int64((timeDifferenceInMillis / (1000 * 60)).truncatingRemainder(dividingBy: 60))
        let seconds = Int64((timeDifferenceInMillis / 1000).truncatingRemainder(dividingBy: 60))

        return String(format: "T-%02d:%02d:%02d:%02d", days, hours, minutes, seconds)
    }
}
