//
//  StringUtils.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 20/08/2023.
//

import Foundation

extension String? {
    
    func toCoreType() -> CoreType {
        switch self {
        case "Core":
            return CoreType.CORE
        case "Strap-On Booster":
            return CoreType.BOOSTER
        default:
            return CoreType.OTHER
        }
    }
    
    func toCrewStatus() -> CrewStatus {
        switch self {
        case "Active":
            return CrewStatus.ACTIVE
        case "Inactive":
            return CrewStatus.INACTIVE
        case "Retired":
            return CrewStatus.RETIRED
        case "Deceased":
            return CrewStatus.DECEASED
        case "In-Training":
            return CrewStatus.IN_TRAINING
        case "Lost In Training":
            return CrewStatus.LOST_IN_TRAINING
        default:
            return CrewStatus.UNKNOWN
        }
    }
}
