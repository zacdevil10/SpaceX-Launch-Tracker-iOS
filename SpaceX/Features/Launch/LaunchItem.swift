//
//  DomainObject.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 19/08/2023.
//

import Foundation

struct LaunchItem : Identifiable {
    let id: String
    let upcoming: Bool
    let missionPatch: String?
    let missionName: String
    let rocket: String?
    let launchDate: String?
    let launchDateUnix: Double?
    let launchLocation: String?
    let launchLocationMap: String?
    let launchLocationMapUrl: String?
    let status: Status
    let holdReason: String?
    let failReason: String?
    let description: String?
    let type: String?
    let orbit: String?
    let webcast: [VideoItem]
    let webcastLive: Bool
    let firstStage: [FirstStageItem]?
    let crew: [CrewItem]?
    
    init(
        response: LaunchResponse
    ) {
        self.id = response.id
        self.upcoming = response.status.isUpcoming()
        self.missionPatch = response.missionPatches?.first?.imageUrl
        self.missionName = response.mission?.name ?? response.name
        self.rocket = response.rocket?.configuration?.name
        self.launchDate = response.net?.formatLaunchDate()
        self.launchDateUnix = response.net?.formatLaunchDateToMillis()
        self.launchLocation = response.pad?.name
        self.launchLocationMap = response.pad?.mapImage
        self.launchLocationMapUrl = response.pad?.mapUrl
        self.status = Status(type: response.status?.id, name: response.status?.name, description: response.status?.description)
        self.holdReason = response.holdReason
        self.failReason = response.failReason
        self.description = response.mission?.description
        self.type = response.mission?.type
        self.orbit = response.mission?.orbit?.name
        self.webcast = response.video.groupBy(by: { $0.title }).values.compactMap { $0.min { a, b in a.priority < b.priority } }.map { VideoItem(response: $0) }
        self.webcastLive = response.webcastLive ?? false
        self.firstStage = response.rocket?.launcherStage?.compactMap { FirstStageItem(response: $0) }
        self.crew = response.rocket?.spacecraftStage?.launchCrew?.compactMap { CrewItem(response: $0) }
    }
    
    init(
        id: String,
        upcoming: Bool,
        missionPatch: String?,
        missionName: String,
        rocket: String?,
        launchDate: String?,
        launchDateUnix: Double?,
        launchLocation: String?,
        launchLocationMap: String?,
        launchLocationMapUrl: String?,
        status: Status, holdReason: String?,
        failReason: String?,
        description: String?,
        type: String?,
        orbit: String?,
        webcast: [VideoItem],
        webcastLive: Bool,
        firstStage: [FirstStageItem]?,
        crew: [CrewItem]?
    ) {
        self.id = id
        self.upcoming = upcoming
        self.missionPatch = missionPatch
        self.missionName = missionName
        self.rocket = rocket
        self.launchDate = launchDate
        self.launchDateUnix = launchDateUnix
        self.launchLocation = launchLocation
        self.launchLocationMap = launchLocationMap
        self.launchLocationMapUrl = launchLocationMapUrl
        self.status = status
        self.holdReason = holdReason
        self.failReason = failReason
        self.description = description
        self.type = type
        self.orbit = orbit
        self.webcast = webcast
        self.webcastLive = webcastLive
        self.firstStage = firstStage
        self.crew = crew
    }
    
    struct Status {
        let type: Int?
        let name: String?
        let description: String?
    }
    
    func countdown() -> String? {
        let remaining = calculateCountdown()
        
        if upcoming && !webcastLive && remaining > 0 {
            return remaining.daysHoursMinutesSeconds
        } else if webcastLive {
            return "Webcast Live"
        } else {
            return nil
        }
    }
    
    private func calculateCountdown() -> Double {
        return (launchDateUnix ?? 0) - (Date().timeIntervalSince1970 * 1000)
    }
    
}

extension LaunchItem {
    
    func isReused() -> Bool {
        if self.rocket == "Falcon 9" {
            return self.firstStage?.first?.reused ?? false
        } else {
            return false
        }
    }
    
    func landingPad() -> String? {
        if self.rocket == "Falcon 9" {
            if let landingLocation = self.firstStage?.first?.landingLocation {
                if landingLocation == "N/A" {
                    return nil
                } else {
                    return landingLocation
                }
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}

extension LaunchResponse.Status? {
    
    func isUpcoming() -> Bool {
        var isUpcoming: Bool
        
        if let id = self?.id {
            isUpcoming = [1, 2, 5, 6, 8].contains(id)
        } else {
            isUpcoming = false
        }
        return isUpcoming
    }
}

struct FirstStageItem {
    let id: String
    let serial: String
    let type: CoreType
    let reused: Bool
    let totalFlights: Int?
    let landingAttempt: Bool
    let landingDescription: String?
    let landingType: String?
    let landingLocation: String?
    let landingLocationFull: String?
    let previousFlight: String?
    let turnAroundTimeDays: Int?
    
    init(
        response: LaunchResponse.Rocket.LauncherStage
    ) {
        self.id = String(response.id)
        self.serial = response.launcher?.serialNumber ?? "Unknown"
        self.type = response.type.toCoreType()
        self.reused = response.reused ?? false
        self.totalFlights = response.launcher?.flights
        self.landingAttempt = response.landing?.attempt ?? false
        self.landingDescription = response.landing?.description
        self.landingType = response.landing?.type?.abbrev
        self.landingLocation = response.landing?.location?.abbrev
        self.landingLocationFull = response.landing?.location?.name
        self.previousFlight = response.previousFlight?.name
        if response.turnAroundTimeDays == 0 && (response.launcher?.flights ?? 0) < 2 {
            self.turnAroundTimeDays = nil
        } else {
            self.turnAroundTimeDays = response.turnAroundTimeDays
        }
    }
    
    init(
        id: String,
        serial: String,
        type: CoreType,
        reused: Bool,
        totalFlights: Int?,
        landingAttempt: Bool,
        landingDescription: String?,
        landingType: String?,
        landingLocation: String?,
        landingLocationFull: String?,
        previousFlight: String?,
        turnAroundTimeDays: Int?
    ) {
        self.id = id
        self.serial = serial
        self.type = type
        self.reused = reused
        self.totalFlights = totalFlights
        self.landingAttempt = landingAttempt
        self.landingDescription = landingDescription
        self.landingType = landingType
        self.landingLocation = landingLocation
        self.landingLocationFull = landingLocationFull
        self.previousFlight = previousFlight
        self.turnAroundTimeDays = turnAroundTimeDays
    }
}

struct CrewItem {
    let id: String
    let name: String?
    let status: CrewStatus
    let agency: String?
    let bio: String?
    let image: String?
    let role: String?
    let firstFlight: String?
    
    init(
        response: LaunchResponse.Rocket.SpacecraftStage.LaunchCrew
    ) {
        self.id = String(response.id)
        self.name = response.astronaut?.name
        self.status = response.astronaut?.status?.name.toCrewStatus() ?? CrewStatus.UNKNOWN
        self.agency = response.astronaut?.agency?.name
        self.bio = response.astronaut?.bio
        self.image = response.astronaut?.profileImage
        self.role = response.role?.role
        self.firstFlight = response.astronaut?.firstFlight?.formatCrewDate()
    }
    
    init(
        id: String,
        name: String?,
        status: CrewStatus,
        agency: String?,
        bio: String?,
        image: String?,
        role: String?,
        firstFlight: String?
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.agency = agency
        self.bio = bio
        self.image = image
        self.role = role
        self.firstFlight = firstFlight
    }
}

struct VideoItem : Identifiable {
    let id: UUID
    let title: String?
    let description: String?
    let imageUrl: String?
    let url: String?
    
    init(
        response: LaunchResponse.Video
    ) {
        self.id = response.id
        self.title = response.title
        self.description = response.description
        self.imageUrl = response.featureImage
        self.url = response.url
    }
    
    init(
        id: UUID,
        title: String?,
        description: String?,
        imageUrl: String?,
        url: String?
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
        self.url = url
    }
}
