//
//  LaunchDetails.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 18/08/2023.
//

import SwiftUI
import MapKit

struct LaunchDetails: View {
    let launch: LaunchItem
    
    var body: some View {
        List {
            if launch.countdown() != nil {
                CountdownView(countdown: launch.countdown)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity)
                    .padding([.top, .horizontal])
            }
            
            LaunchView(
                patch: launch.missionPatch,
                vehicle: launch.rocket,
                missionName: launch.missionName,
                date: launch.launchDate,
                isReused: launch.isReused(),
                landingPad: launch.landingPad()
            )
            .listRowSeparator(.hidden)
            
            if let holdReason = launch.holdReason, launch.holdReason?.isEmpty == false {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Hold")
                        .font(.headline)
                    
                    Text(holdReason)
                        .padding(.top, 8.0)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.all, 16.0)
                .outlineCard()
                .listRowSeparator(.hidden)
            }
            
            if let description = launch.description {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Mission")
                        .font(.headline)
                    
                    Text(description)
                        .padding(.top, 8)
                    
                    if let type = launch.type {
                        LabelValueView(label: "Type:", value: type)
                            .padding(.top, 8)
                    }
                    
                    if let orbit = launch.orbit {
                        LabelValueView(label: "Orbit", value: orbit)
                            .padding(.top, 8)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.all, 16.0)
                .outlineCard()
                .listRowSeparator(.hidden)
            }
            
            ForEach(launch.webcast.compactMap{ $0 }) { webcast in
                if let title = webcast.title {
                    VideoView(image: webcast.imageUrl, title: title)
                        .outlineCard()
                        .listRowSeparator(.hidden)
                }
            }
            
            if !launch.webcastLive && launch.upcoming {
                Button(action: {}) {
                    Text("Create event")
                        .frame(maxWidth: .infinity)
                }
                .tint(.accentColor)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
                .frame(maxWidth: .infinity)
                .listRowSeparator(.hidden)
            }
            
            if launch.status.type != nil {
                VStack(alignment: .leading, spacing: 0) {
                    LabelValueView(label: "Status:", value: launch.status.name ?? "")
                    
                    Text(launch.status.type == 4 ? launch.failReason ?? "" : launch.status.description ?? "")
                        .padding(.top, 8)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.all, 16.0)
                .outlineCard()
                .listRowSeparator(.hidden)
            }
            
            if let launchLocation = launch.launchLocation, let map = launch.launchLocationMap, let mapUrl = launch.launchLocationMapUrl {
                VStack(alignment: .leading, spacing: 0) {
                    AsyncImage(url: URL(string: map), content: view)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            UIApplication.shared.open(URL(string: mapUrl)!)
                        }
                    
                    LabelValueView(label: "Launch site:", value: launchLocation)
                        .padding(.top, 8)
                        .padding([.horizontal, .bottom], 16)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .outlineCard()
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(PlainListStyle())
    }
    
    @ViewBuilder
    private func view(for phase: AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            HStack {
                Spacer()
                
                ProgressView()
                
                Spacer()
            }
        case .success(let image):
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(16)
        default:
            Image(systemName: "photo")
                .resizable()
                .foregroundColor(Color.gray.opacity(0.5))
                .padding(.all, 4.0)
        }
    }
}

struct LaunchDetails_Previews: PreviewProvider {
    static var previews: some View {
        LaunchDetails(
            launch: LaunchItem(
                id: "id",
                upcoming: true,
                missionPatch: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/mission_patch_images/space2520x252_mission_patch_20221011205756.png",
                missionName: "Starlink Group 7-1",
                rocket: "Falcon 9",
                launchDate: "23 Oct 2023 - 07:04",
                launchDateUnix: 158697306,
                launchLocation: "Space Launch Complex 4E",
                launchLocationMap: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/launch_images/pad_16_20200803143532.jpg",
                launchLocationMapUrl: "https://www.google.com/maps?q=34.632,-120.611",
                status: LaunchItem.Status(type: 1, name: "Status Name", description: "Status Description"),
                holdReason: "Hold Reason",
                failReason: "Fail Reason",
                description: "Description",
                type: "Communications",
                orbit: "Low Earth Orbit",
                webcast: [
                    VideoItem(
                        id: UUID(),
                        title: "Starlink Mission",
                        description: "SpaceX is targeting Thursday, August 17 at 12:01 a.m. PT (7:01 UTC) for a Falcon 9 launch of 21 Starlink satellites to low-Earth orbit from Space Launch Comp...",
                        imageUrl: "https://i.ytimg.com/vi/agYuEAkEljw/maxresdefault_live.jpg",
                        url: "https://www.youtube.com/live/agYuEAkEljw"
                    )
                ],
                webcastLive: false,
                firstStage: [
                    FirstStageItem(
                        id: "id",
                        serial: "Serial",
                        type: CoreType.CORE,
                        reused: true,
                        totalFlights: 5,
                        landingAttempt: true,
                        landingDescription: "Landing Description",
                        landingType: "Landing Type",
                        landingLocation: "",
                        landingLocationFull: "",
                        previousFlight: "",
                        turnAroundTimeDays: 50
                    )
                ],
                crew: []
            )
        )
    }
}
