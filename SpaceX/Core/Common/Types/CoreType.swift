//
//  CoreType.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 19/08/2023.
//

import Foundation

enum CoreType : String, Identifiable {
    var id: Self {
        return self
    }
    
    case CORE = "Core"
    case BOOSTER = "Strap-On Booster"
    case OTHER = "Other"
}
