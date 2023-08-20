//
//  LaunchResponse.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 10/08/2023.
//

import Foundation

struct LaunchResponse : Identifiable, Decodable {
    let id: String
    let url: String?
    let slug: String?
    let name: String
    let status: Status?
    let lastUpdated: String?
    let net: String?
    let windowEnd: String?
    let windowStart: String?
    let probability: Int?
    let holdReason: String?
    let failReason: String?
    let hashtag: String?
    let launchServiceProvider: LaunchServiceProvider?
    let rocket: Rocket?
    let mission: Mission?
    let pad: Pad?
    let video: [Video]
    let webcastLive: Bool?
    let image: String?
    let infographic: String?
    let program: [Program]?
    let orbitalLaunchAttemptCount: Int?
    let locationLaunchAttemptCount: Int?
    let padLaunchAttemptCount: Int?
    let agencyLaunchAttemptCount: Int?
    let orbitalLaunchAttemptCountYear: Int?
    let locationLaunchAttemptCountYear: Int?
    let padLaunchAttemptCountYear: Int?
    let agencyLaunchAttemptCountYear: Int?
    let missionPatches: [MissionPatch]?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case url
        case slug
        case name
        case status
        case lastUpdated = "last_updated"
        case net
        case windowEnd = "window_end"
        case windowStart = "window_start"
        case probability
        case holdReason = "holdreason"
        case failReason = "failreason"
        case hashtag
        case launchServiceProvider = "launch_service_provider"
        case rocket
        case mission
        case pad
        case video = "vidURLs"
        case webcastLive = "webcast_live"
        case image
        case infographic
        case program
        case orbitalLaunchAttemptCount = "orbital_launch_attempt_count"
        case locationLaunchAttemptCount = "location_launch_attempt_count"
        case padLaunchAttemptCount = "pad_launch_attempt_count"
        case agencyLaunchAttemptCount = "agency_launch_attempt_count"
        case orbitalLaunchAttemptCountYear = "orbital_launch_attempt_count_year"
        case locationLaunchAttemptCountYear = "location_launch_attempt_count_year"
        case padLaunchAttemptCountYear = "pad_launch_attempt_count_year"
        case agencyLaunchAttemptCountYear = "agency_launch_attempt_count_year"
        case missionPatches = "mission_patches"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.slug = try container.decodeIfPresent(String.self, forKey: .slug)
        self.name = try container.decode(String.self, forKey: .name)
        self.status = try container.decodeIfPresent(Status.self, forKey: .status)
        self.lastUpdated = try container.decodeIfPresent(String.self, forKey: .lastUpdated)
        self.net = try container.decodeIfPresent(String.self, forKey: .net)
        self.windowEnd = try container.decodeIfPresent(String.self, forKey: .windowEnd)
        self.windowStart = try container.decodeIfPresent(String.self, forKey: .windowStart)
        self.probability = try container.decodeIfPresent(Int.self, forKey: .probability)
        self.holdReason = try container.decodeIfPresent(String.self, forKey: .holdReason)
        self.failReason = try container.decodeIfPresent(String.self, forKey: .failReason)
        self.hashtag = try container.decodeIfPresent(String.self, forKey: .hashtag)
        self.launchServiceProvider = try container.decodeIfPresent(LaunchServiceProvider.self, forKey: .launchServiceProvider)
        self.rocket = try container.decodeIfPresent(Rocket.self, forKey: .rocket)
        self.mission = try container.decodeIfPresent(Mission.self, forKey: .mission)
        self.pad = try container.decodeIfPresent(Pad.self, forKey: .pad)
        self.video = try container.decodeIfPresent([Video].self, forKey: .video) ?? []
        self.webcastLive = try container.decodeIfPresent(Bool.self, forKey: .webcastLive)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.infographic = try container.decodeIfPresent(String.self, forKey: .infographic)
        self.program = try container.decodeIfPresent([Program].self, forKey: .program)
        self.orbitalLaunchAttemptCount = try container.decodeIfPresent(Int.self, forKey: .orbitalLaunchAttemptCount)
        self.locationLaunchAttemptCount = try container.decodeIfPresent(Int.self, forKey: .locationLaunchAttemptCount)
        self.padLaunchAttemptCount = try container.decodeIfPresent(Int.self, forKey: .padLaunchAttemptCount)
        self.agencyLaunchAttemptCount = try container.decodeIfPresent(Int.self, forKey: .agencyLaunchAttemptCount)
        self.orbitalLaunchAttemptCountYear = try container.decodeIfPresent(Int.self, forKey: .orbitalLaunchAttemptCountYear)
        self.locationLaunchAttemptCountYear = try container.decodeIfPresent(Int.self, forKey: .locationLaunchAttemptCountYear)
        self.padLaunchAttemptCountYear = try container.decodeIfPresent(Int.self, forKey: .padLaunchAttemptCountYear)
        self.agencyLaunchAttemptCountYear = try container.decodeIfPresent(Int.self, forKey: .agencyLaunchAttemptCountYear)
        self.missionPatches = try container.decodeIfPresent([MissionPatch].self, forKey: .missionPatches)
    }
    
    struct Status : Identifiable, Decodable {
        let id: Int
        let name: String?
        let abbrev: String?
        let description: String?
        
        private enum CodingKeys : CodingKey {
            case id
            case name
            case abbrev
            case description
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try values.decode(Int.self, forKey: .id)
            self.name = try values.decodeIfPresent(String.self, forKey: .name)
            self.abbrev = try values.decodeIfPresent(String.self, forKey: .abbrev)
            self.description = try values.decodeIfPresent(String.self, forKey: .description)
        }
    }
    
    struct LaunchServiceProvider : Identifiable, Decodable {
        let id: Int
        let url: String?
        let name: String?
        let type: String?
        
        private enum CodingKeys : CodingKey {
            case id
            case url
            case name
            case type
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(Int.self, forKey: .id)
            self.url = try container.decodeIfPresent(String.self, forKey: .url)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.type = try container.decodeIfPresent(String.self, forKey: .type)
        }
    }
    
    struct Rocket : Identifiable, Decodable {
        let id: Int
        let configuration: Configuration?
        let launcherStage: [LauncherStage]?
        let spacecraftStage: SpacecraftStage?
        
        private enum CodingKeys : String, CodingKey {
            case id
            case configuration
            case launcherStage = "launcher_stage"
            case spacecraftStage = "spacecraft_stage"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try values.decode(Int.self, forKey: .id)
            self.configuration = try values.decodeIfPresent(Configuration.self, forKey: .configuration)
            self.launcherStage = try values.decodeIfPresent([LauncherStage].self, forKey: .launcherStage)
            self.spacecraftStage = try values.decodeIfPresent(SpacecraftStage.self, forKey: .spacecraftStage)
        }
        
        struct Configuration : Identifiable, Decodable {
            let id: Int
            let url: String?
            let name: String?
            let family: String?
            let fullName: String?
            let variant: String?
            
            private enum CodingKeys : String, CodingKey {
                case id
                case url
                case name
                case family
                case fullName = "full_name"
                case variant
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.id = try container.decode(Int.self, forKey: .id)
                self.url = try container.decodeIfPresent(String.self, forKey: .url)
                self.name = try container.decodeIfPresent(String.self, forKey: .name)
                self.family = try container.decodeIfPresent(String.self, forKey: .family)
                self.fullName = try container.decodeIfPresent(String.self, forKey: .fullName)
                self.variant = try container.decodeIfPresent(String.self, forKey: .variant)
            }
        }
        
        struct LauncherStage : Identifiable, Decodable {
            let id: Int
            let type: String?
            let reused: Bool?
            let launcher: Launcher?
            let landing: Landing?
            let turnAroundTimeDays: Int?
            let previousFlight: PreviousFlight?
            
            private enum CodingKeys : String, CodingKey {
                case id
                case type
                case reused
                case launcher
                case landing
                case turnAroundTimeDays = "turn_around_time_days"
                case previousFlight = "previous_flight"
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.id = try container.decode(Int.self, forKey: .id)
                self.type = try container.decodeIfPresent(String.self, forKey: .type)
                self.reused = try container.decodeIfPresent(Bool.self, forKey: .reused)
                self.launcher = try container.decodeIfPresent(Launcher.self, forKey: .launcher)
                self.landing = try container.decodeIfPresent(Landing.self, forKey: .landing)
                self.turnAroundTimeDays = try container.decodeIfPresent(Int.self, forKey: .turnAroundTimeDays)
                self.previousFlight = try container.decodeIfPresent(PreviousFlight.self, forKey: .previousFlight)
            }
            
            struct Launcher : Identifiable, Decodable {
                let id: Int
                let serialNumber: String?
                let status: String?
                let flights: Int?
                
                private enum CodingKeys : String, CodingKey {
                    case id
                    case serialNumber = "serial_number"
                    case status
                    case flights
                }
                
                init(from decoder: Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    self.id = try container.decode(Int.self, forKey: .id)
                    self.serialNumber = try container.decodeIfPresent(String.self, forKey: .serialNumber)
                    self.status = try container.decodeIfPresent(String.self, forKey: .status)
                    self.flights = try container.decodeIfPresent(Int.self, forKey: .flights)
                }
            }
            
            struct Landing : Identifiable, Decodable {
                let id: Int
                let attempt: Bool?
                let success: Bool?
                let description: String?
                let location: Location?
                let type: LandingType?
                
                private enum CodingKeys: CodingKey {
                    case id
                    case attempt
                    case success
                    case description
                    case location
                    case type
                }
                
                init(from decoder: Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    self.id = try container.decode(Int.self, forKey: .id)
                    self.attempt = try container.decodeIfPresent(Bool.self, forKey: .attempt)
                    self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
                    self.description = try container.decodeIfPresent(String.self, forKey: .description)
                    self.location = try container.decodeIfPresent(Location.self, forKey: .location)
                    self.type = try container.decodeIfPresent(LandingType.self, forKey: .type)
                }
                
                struct Location : Identifiable, Decodable {
                    let id: Int
                    let name: String?
                    let abbrev: String?
                    let description: String?
                    let successsfulLandings: Int?
                    
                    private enum CodingKeys : String, CodingKey {
                        case id
                        case name
                        case abbrev
                        case description
                        case successsfulLandings = "successful_landings"
                    }
                    
                    init(from decoder: Decoder) throws {
                        let container = try decoder.container(keyedBy: CodingKeys.self)
                        self.id = try container.decode(Int.self, forKey: .id)
                        self.name = try container.decodeIfPresent(String.self, forKey: .name)
                        self.abbrev = try container.decodeIfPresent(String.self, forKey: .abbrev)
                        self.description = try container.decodeIfPresent(String.self, forKey: .description)
                        self.successsfulLandings = try container.decodeIfPresent(Int.self, forKey: .successsfulLandings)
                    }
                }
                
                struct LandingType : Identifiable, Decodable {
                    let id: Int
                    let name: String?
                    let abbrev: String?
                    let description: String?
                    
                    private enum CodingKeys: CodingKey {
                        case id
                        case name
                        case abbrev
                        case description
                    }
                    
                    init(from decoder: Decoder) throws {
                        let container = try decoder.container(keyedBy: CodingKeys.self)
                        self.id = try container.decode(Int.self, forKey: .id)
                        self.name = try container.decodeIfPresent(String.self, forKey: .name)
                        self.abbrev = try container.decodeIfPresent(String.self, forKey: .abbrev)
                        self.description = try container.decodeIfPresent(String.self, forKey: .description)
                    }
                }
            }
            
            struct PreviousFlight : Identifiable, Decodable {
                let id: String
                let name: String?
                
                enum CodingKeys: CodingKey {
                    case id
                    case name
                }
                
                init(from decoder: Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    self.id = try container.decode(String.self, forKey: .id)
                    self.name = try container.decodeIfPresent(String.self, forKey: .name)
                }
            }
        }
        
        struct SpacecraftStage : Identifiable, Decodable {
            let id: Int
            let destination: String?
            let launchCrew: [LaunchCrew]?
            
            enum CodingKeys: String, CodingKey {
                case id
                case destination
                case launchCrew = "launch_crew"
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.id = try container.decode(Int.self, forKey: .id)
                self.destination = try container.decodeIfPresent(String.self, forKey: .destination)
                self.launchCrew = try container.decodeIfPresent([LaunchCrew].self, forKey: .launchCrew)
            }
            
            struct LaunchCrew : Identifiable, Decodable {
                let id: Int
                let role: Role?
                let astronaut: Astronaut?
                
                enum CodingKeys: CodingKey {
                    case id
                    case role
                    case astronaut
                }
                
                init(from decoder: Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    self.id = try container.decode(Int.self, forKey: .id)
                    self.role = try container.decodeIfPresent(Role.self, forKey: .role)
                    self.astronaut = try container.decodeIfPresent(Astronaut.self, forKey: .astronaut)
                }
                
                struct Role : Identifiable, Decodable {
                    let id: Int
                    let role: String?
                    let priority: Int?
                    
                    private enum CodingKeys: CodingKey {
                        case id
                        case role
                        case priority
                    }
                    
                    init(from decoder: Decoder) throws {
                        let container = try decoder.container(keyedBy: CodingKeys.self)
                        self.id = try container.decode(Int.self, forKey: .id)
                        self.role = try container.decodeIfPresent(String.self, forKey: .role)
                        self.priority = try container.decodeIfPresent(Int.self, forKey: .priority)
                    }
                }
                
                struct Astronaut : Identifiable, Decodable {
                    let id: Int
                    let name: String?
                    let status: Status?
                    let agency: Agency?
                    let bio: String?
                    let profileImage: String?
                    let lastFlight: String?
                    let firstFlight: String?
                    
                    private enum CodingKeys: String, CodingKey {
                        case id
                        case name
                        case status
                        case agency
                        case bio
                        case profileImage = "profile_image"
                        case lastFlight = "last_flight"
                        case firstFlight = "first_flight"
                    }
                    
                    init(from decoder: Decoder) throws {
                        let container = try decoder.container(keyedBy: CodingKeys.self)
                        self.id = try container.decode(Int.self, forKey: .id)
                        self.name = try container.decodeIfPresent(String.self, forKey: .name)
                        self.status = try container.decodeIfPresent(Status.self, forKey: .status)
                        self.agency = try container.decodeIfPresent(Agency.self, forKey: .agency)
                        self.bio = try container.decodeIfPresent(String.self, forKey: .bio)
                        self.profileImage = try container.decodeIfPresent(String.self, forKey: .profileImage)
                        self.lastFlight = try container.decodeIfPresent(String.self, forKey: .lastFlight)
                        self.firstFlight = try container.decodeIfPresent(String.self, forKey: .firstFlight)
                    }
                    
                    struct Status : Identifiable, Decodable {
                        let id: Int
                        let name: String?
                        
                        private enum CodingKeys: CodingKey {
                            case id
                            case name
                        }
                        
                        init(from decoder: Decoder) throws {
                            let container = try decoder.container(keyedBy: CodingKeys.self)
                            self.id = try container.decode(Int.self, forKey: .id)
                            self.name = try container.decodeIfPresent(String.self, forKey: .name)
                        }
                    }
                    
                    struct Agency: Identifiable, Decodable {
                        let id: Int
                        let name: String?
                        
                        private enum CodingKeys: CodingKey {
                            case id
                            case name
                        }
                        
                        init(from decoder: Decoder) throws {
                            let container = try decoder.container(keyedBy: CodingKeys.self)
                            self.id = try container.decode(Int.self, forKey: .id)
                            self.name = try container.decodeIfPresent(String.self, forKey: .name)
                        }
                    }
                }
            }
        }
    }
    
    struct Mission : Identifiable, Decodable {
        let id: Int
        let name: String?
        let description: String?
        let launchDesignator: String?
        let type: String?
        let orbit: Orbit?
        
        private enum CodingKeys: String, CodingKey {
            case id
            case name
            case description
            case launchDesignator = "launch_designator"
            case type
            case orbit
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(Int.self, forKey: .id)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.launchDesignator = try container.decodeIfPresent(String.self, forKey: .launchDesignator)
            self.type = try container.decodeIfPresent(String.self, forKey: .type)
            self.orbit = try container.decodeIfPresent(Orbit.self, forKey: .orbit)
        }
        
        struct Orbit : Identifiable, Decodable {
            let id: Int
            let name: String?
            let abbrev: String?
            
            private enum CodingKeys: CodingKey {
                case id
                case name
                case abbrev
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.id = try container.decode(Int.self, forKey: .id)
                self.name = try container.decodeIfPresent(String.self, forKey: .name)
                self.abbrev = try container.decodeIfPresent(String.self, forKey: .abbrev)
            }
        }
    }
    
    struct Pad : Identifiable, Decodable {
        let id: Int
        let url: String?
        let agencyId: Int?
        let name: String?
        let infoUrl: String?
        let wikiUrl: String?
        let mapUrl: String?
        let latitude: String?
        let longitude: String?
        let location: Location?
        let mapImage: String?
        let totalLaunchCount: Int?
        let orbitalLaunchAttemptCount: Int?
        
        private enum CodingKeys: String, CodingKey {
            case id
            case url
            case agencyId = "agency_id"
            case name
            case infoUrl = "info_url"
            case wikiUrl = "wiki_url"
            case mapUrl = "map_url"
            case latitude
            case longitude
            case location
            case mapImage = "map_image"
            case totalLaunchCount = "total_launch_count"
            case orbitalLaunchAttemptCount = "orbital_launch_attempt_count"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(Int.self, forKey: .id)
            self.url = try container.decodeIfPresent(String.self, forKey: .url)
            self.agencyId = try container.decodeIfPresent(Int.self, forKey: .agencyId)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.infoUrl = try container.decodeIfPresent(String.self, forKey: .infoUrl)
            self.wikiUrl = try container.decodeIfPresent(String.self, forKey: .wikiUrl)
            self.mapUrl = try container.decodeIfPresent(String.self, forKey: .mapUrl)
            self.latitude = try container.decodeIfPresent(String.self, forKey: .latitude)
            self.longitude = try container.decodeIfPresent(String.self, forKey: .longitude)
            self.location = try container.decodeIfPresent(Location.self, forKey: .location)
            self.mapImage = try container.decodeIfPresent(String.self, forKey: .mapImage)
            self.totalLaunchCount = try container.decodeIfPresent(Int.self, forKey: .totalLaunchCount)
            self.orbitalLaunchAttemptCount = try container.decodeIfPresent(Int.self, forKey: .orbitalLaunchAttemptCount)
        }
        
        struct Location : Identifiable, Decodable {
            let id: Int
            let url: String?
            let name: String?
            let countryCode: String?
            let mapImage: String?
            let totalLaunchCount: Int?
            let totalLandingCount: Int?
            
            private enum CodingKeys: String, CodingKey {
                case id
                case url
                case name
                case countryCode = "country_code"
                case mapImage = "map_image"
                case totalLaunchCount = "total_launch_count"
                case totalLandingCount = "total_landing_count"
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.id = try container.decode(Int.self, forKey: .id)
                self.url = try container.decodeIfPresent(String.self, forKey: .url)
                self.name = try container.decodeIfPresent(String.self, forKey: .name)
                self.countryCode = try container.decodeIfPresent(String.self, forKey: .countryCode)
                self.mapImage = try container.decodeIfPresent(String.self, forKey: .mapImage)
                self.totalLaunchCount = try container.decodeIfPresent(Int.self, forKey: .totalLaunchCount)
                self.totalLandingCount = try container.decodeIfPresent(Int.self, forKey: .totalLandingCount)
            }
        }
    }
    
    struct Video : Identifiable, Decodable {
        let id: UUID
        let priority: Int
        let title: String?
        let description: String?
        let featureImage: String?
        let url: String?
        
        private enum CodingKeys: String, CodingKey {
            case priority
            case title
            case description
            case featureImage = "feature_image"
            case url
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = UUID()
            self.priority = try container.decode(Int.self, forKey: .priority)
            self.title = try container.decodeIfPresent(String.self, forKey: .title)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.featureImage = try container.decodeIfPresent(String.self, forKey: .featureImage)
            self.url = try container.decodeIfPresent(String.self, forKey: .url)
        }
    }
    
    struct Program : Identifiable, Decodable {
        let id: Int
        let url: String?
        let name: String?
        let description: String?
        let agencies: [Agency]?
        let imageUrl: String?
        let startDate: String?
        let endDate: String?
        let infoUrl: String?
        let wikiUrl: String?
        let missionPatches: [MissionPatch]?
        
        private enum CodingKeys: String, CodingKey {
            case id
            case url
            case name
            case description
            case agencies
            case imageUrl = "image_url"
            case startDate = "start_date"
            case endDate = "end_date"
            case infoUrl = "info_url"
            case wikiUrl = "wiki_url"
            case missionPatches = "mission_patches"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(Int.self, forKey: .id)
            self.url = try container.decodeIfPresent(String.self, forKey: .url)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.agencies = try container.decodeIfPresent([Agency].self, forKey: .agencies)
            self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
            self.startDate = try container.decodeIfPresent(String.self, forKey: .startDate)
            self.endDate = try container.decodeIfPresent(String.self, forKey: .endDate)
            self.infoUrl = try container.decodeIfPresent(String.self, forKey: .infoUrl)
            self.wikiUrl = try container.decodeIfPresent(String.self, forKey: .wikiUrl)
            self.missionPatches = try container.decodeIfPresent([MissionPatch].self, forKey: .missionPatches)
        }
        
        struct Agency : Identifiable, Decodable {
            let id: Int
            let url: String?
            let name: String?
            let type: String?
            
            private enum CodingKeys: CodingKey {
                case id
                case url
                case name
                case type
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.id = try container.decode(Int.self, forKey: .id)
                self.url = try container.decodeIfPresent(String.self, forKey: .url)
                self.name = try container.decodeIfPresent(String.self, forKey: .name)
                self.type = try container.decodeIfPresent(String.self, forKey: .type)
            }
        }
    }
    
    struct MissionPatch : Identifiable, Decodable {
        let id: Int
        let name: String?
        let priority: Int?
        let imageUrl: String?
        let agency: Program.Agency?
        
        private enum CodingKeys: String, CodingKey {
            case id
            case name
            case priority
            case imageUrl = "image_url"
            case agency
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(Int.self, forKey: .id)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.priority = try container.decodeIfPresent(Int.self, forKey: .priority)
            self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
            self.agency = try container.decodeIfPresent(Program.Agency.self, forKey: .agency)
        }
    }
}
