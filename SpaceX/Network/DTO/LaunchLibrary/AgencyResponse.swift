//
//  AgencyResponse.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 03/03/2024.
//

import Foundation

struct AgencyResponse : Identifiable, Decodable {
    let id: Int
    let name: String
    let description: String
    let administrator: String
    let foundingYear: String
    let totalLaunchCount: Int
    let successfulLaunches: Int
    let consecutiveSuccessfulLaunches: Int
    let failedLaunches: Int
    let pendingLaunces: Int
    let successfulLandings: Int
    let failedLandings: Int
    let attemptedLandings: Int
    let consecutiveSuccessfulLandings: Int
    let infoUrl: String
    let wikiUrl: String
    let launcherList: [Launcher]
    let spacecraftList: [Spacecraft]
    
    private enum CodingKeys : String, CodingKey {
        case id
        case name
        case description
        case administrator
        case foundingYear = "founding_year"
        case totalLaunchCount = "total_launch_count"
        case successfulLaunches = "successful_launches"
        case consecutiveSuccessfulLaunches = "consecutive_successful_launches"
        case failedLaunches = "failed_launches"
        case pendingLaunces = "pending_launches"
        case successfulLandings = "successful_landings"
        case failedLandings = "failed_landings"
        case attemptedLandings = "attempted_landings"
        case consecutiveSuccessfulLandings = "consecutive_successful_landings"
        case infoUrl = "info_url"
        case wikiUrl = "wiki_url"
        case launcherList = "launcher_list"
        case spacecraftList = "spacecraft_list"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.administrator = try container.decode(String.self, forKey: .administrator)
        self.foundingYear = try container.decode(String.self, forKey: .foundingYear)
        self.totalLaunchCount = try container.decode(Int.self, forKey: .totalLaunchCount)
        self.successfulLaunches = try container.decode(Int.self, forKey: .successfulLaunches)
        self.consecutiveSuccessfulLaunches = try container.decode(Int.self, forKey: .consecutiveSuccessfulLaunches)
        self.failedLaunches = try container.decode(Int.self, forKey: .failedLaunches)
        self.pendingLaunces = try container.decode(Int.self, forKey: .pendingLaunces)
        self.successfulLandings = try container.decode(Int.self, forKey: .successfulLandings)
        self.failedLandings = try container.decode(Int.self, forKey: .failedLandings)
        self.attemptedLandings = try container.decode(Int.self, forKey: .attemptedLandings)
        self.consecutiveSuccessfulLandings = try container.decode(Int.self, forKey: .consecutiveSuccessfulLandings)
        self.infoUrl = try container.decode(String.self, forKey: .infoUrl)
        self.wikiUrl = try container.decode(String.self, forKey: .wikiUrl)
        self.launcherList = try container.decode([AgencyResponse.Launcher].self, forKey: .launcherList)
        self.spacecraftList = try container.decode([AgencyResponse.Spacecraft].self, forKey: .spacecraftList)
    }
    
    struct Launcher : Identifiable, Decodable {
        let id: Int
        let name: String?
        let description: String?
        let family: String?
        let fullName: String?
        let variant: String?
        let minStage: Int?
        let maxStage: Int?
        let length: Float?
        let diameter: Float?
        let maidenFlight: String?
        let launchMass: Int?
        let leoCapacity: Int?
        let gtoCapacity: Int?
        let toThrust: Int?
        let apogee: Int?
        let imageUrl: String?
        let infoUrl: String?
        let wikiUrl: String?
        let consecutiveSuccessfulLaunches: Int?
        let failedLaunches: Int?
        let pendingLaunches: Int?
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case description
            case family
            case fullName = "full_name"
            case variant
            case minStage = "min_stage"
            case maxStage = "max_stage"
            case length
            case diameter
            case maidenFlight = "maiden_flight"
            case launchMass = "launch_mass"
            case leoCapacity = "leo_capacity"
            case gtoCapacity = "gto_capacity"
            case toThrust = "to_thrust"
            case apogee
            case imageUrl = "image_url"
            case infoUrl = "info_url"
            case wikiUrl = "wiki_url"
            case consecutiveSuccessfulLaunches = "consecutive_successful_launches"
            case failedLaunches = "failed_launches"
            case pendingLaunches = "pending_launches"
        }
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<AgencyResponse.Launcher.CodingKeys> = try decoder.container(keyedBy: AgencyResponse.Launcher.CodingKeys.self)
            self.id = try container.decode(Int.self, forKey: AgencyResponse.Launcher.CodingKeys.id)
            self.name = try container.decodeIfPresent(String.self, forKey: AgencyResponse.Launcher.CodingKeys.name)
            self.description = try container.decodeIfPresent(String.self, forKey: AgencyResponse.Launcher.CodingKeys.description)
            self.family = try container.decodeIfPresent(String.self, forKey: AgencyResponse.Launcher.CodingKeys.family)
            self.fullName = try container.decodeIfPresent(String.self, forKey: AgencyResponse.Launcher.CodingKeys.fullName)
            self.variant = try container.decodeIfPresent(String.self, forKey: AgencyResponse.Launcher.CodingKeys.variant)
            self.minStage = try container.decodeIfPresent(Int.self, forKey: AgencyResponse.Launcher.CodingKeys.minStage)
            self.maxStage = try container.decodeIfPresent(Int.self, forKey: AgencyResponse.Launcher.CodingKeys.maxStage)
            self.length = try container.decodeIfPresent(Float.self, forKey: AgencyResponse.Launcher.CodingKeys.length)
            self.diameter = try container.decodeIfPresent(Float.self, forKey: AgencyResponse.Launcher.CodingKeys.diameter)
            self.maidenFlight = try container.decodeIfPresent(String.self, forKey: AgencyResponse.Launcher.CodingKeys.maidenFlight)
            self.launchMass = try container.decodeIfPresent(Int.self, forKey: AgencyResponse.Launcher.CodingKeys.launchMass)
            self.leoCapacity = try container.decodeIfPresent(Int.self, forKey: AgencyResponse.Launcher.CodingKeys.leoCapacity)
            self.gtoCapacity = try container.decodeIfPresent(Int.self, forKey: AgencyResponse.Launcher.CodingKeys.gtoCapacity)
            self.toThrust = try container.decodeIfPresent(Int.self, forKey: AgencyResponse.Launcher.CodingKeys.toThrust)
            self.apogee = try container.decodeIfPresent(Int.self, forKey: AgencyResponse.Launcher.CodingKeys.apogee)
            self.imageUrl = try container.decodeIfPresent(String.self, forKey: AgencyResponse.Launcher.CodingKeys.imageUrl)
            self.infoUrl = try container.decodeIfPresent(String.self, forKey: AgencyResponse.Launcher.CodingKeys.infoUrl)
            self.wikiUrl = try container.decodeIfPresent(String.self, forKey: AgencyResponse.Launcher.CodingKeys.wikiUrl)
            self.consecutiveSuccessfulLaunches = try container.decodeIfPresent(Int.self, forKey: AgencyResponse.Launcher.CodingKeys.consecutiveSuccessfulLaunches)
            self.failedLaunches = try container.decodeIfPresent(Int.self, forKey: AgencyResponse.Launcher.CodingKeys.failedLaunches)
            self.pendingLaunches = try container.decodeIfPresent(Int.self, forKey: AgencyResponse.Launcher.CodingKeys.pendingLaunches)
        }
    }
    
    struct Spacecraft : Identifiable, Decodable {
        let id: Int
        let name: String?
        let inUse: Bool?
        let capability: String?
        let history: String?
        let details: String?
        let maidenFlight: String?
        let height: Float?
        let diameter: Float?
        let humanRated: Bool?
        let crewCapacity: Int?
        let payloadCapacity: Int?
        let flightLife: String?
        let imageUrl: String?
        let wikiLink: String?
        let infoLink: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case inUse = "in_use"
            case capability
            case history
            case details
            case maidenFlight = "maiden_flight"
            case height
            case diameter
            case humanRated = "human_rated"
            case crewCapacity = "crew_capacity"
            case payloadCapacity = "payload_capacity"
            case flightLife = "flight_life"
            case imageUrl = "image_url"
            case wikiLink = "wiki_link"
            case infoLink = "info_link"
        }
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<AgencyResponse.Spacecraft.CodingKeys> = try decoder.container(keyedBy: AgencyResponse.Spacecraft.CodingKeys.self)
            self.id = try container.decode(Int.self, forKey: AgencyResponse.Spacecraft.CodingKeys.id)
            self.name = try container.decodeIfPresent(String.self, forKey: AgencyResponse.Spacecraft.CodingKeys.name)
            self.inUse = try container.decodeIfPresent(Bool.self, forKey: AgencyResponse.Spacecraft.CodingKeys.inUse)
            self.capability = try container.decodeIfPresent(String.self, forKey: AgencyResponse.Spacecraft.CodingKeys.capability)
            self.history = try container.decodeIfPresent(String.self, forKey: AgencyResponse.Spacecraft.CodingKeys.history)
            self.details = try container.decodeIfPresent(String.self, forKey: AgencyResponse.Spacecraft.CodingKeys.details)
            self.maidenFlight = try container.decodeIfPresent(String.self, forKey: AgencyResponse.Spacecraft.CodingKeys.maidenFlight)
            self.height = try container.decodeIfPresent(Float.self, forKey: AgencyResponse.Spacecraft.CodingKeys.height)
            self.diameter = try container.decodeIfPresent(Float.self, forKey: AgencyResponse.Spacecraft.CodingKeys.diameter)
            self.humanRated = try container.decodeIfPresent(Bool.self, forKey: AgencyResponse.Spacecraft.CodingKeys.humanRated)
            self.crewCapacity = try container.decodeIfPresent(Int.self, forKey: AgencyResponse.Spacecraft.CodingKeys.crewCapacity)
            self.payloadCapacity = try container.decodeIfPresent(Int.self, forKey: AgencyResponse.Spacecraft.CodingKeys.payloadCapacity)
            self.flightLife = try container.decodeIfPresent(String.self, forKey: AgencyResponse.Spacecraft.CodingKeys.flightLife)
            self.imageUrl = try container.decodeIfPresent(String.self, forKey: AgencyResponse.Spacecraft.CodingKeys.imageUrl)
            self.wikiLink = try container.decodeIfPresent(String.self, forKey: AgencyResponse.Spacecraft.CodingKeys.wikiLink)
            self.infoLink = try container.decodeIfPresent(String.self, forKey: AgencyResponse.Spacecraft.CodingKeys.infoLink)
        }
    }
}
