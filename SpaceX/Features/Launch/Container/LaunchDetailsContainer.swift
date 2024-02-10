//
//  LaunchDetailsContainer.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 18/08/2023.
//

import SwiftUI

struct LaunchDetailsContainer: View {
    let launch: LaunchItem
    
    var hasFirstStage: Bool
    var hasCrew: Bool
    var tabs: [Tab] = []
    
    init(launch: LaunchItem) {
        self.launch = launch
        
        hasFirstStage = launch.firstStage?.isEmpty == false
        hasCrew = launch.crew?.isEmpty == false
        
        tabs.append(Tab(id: 0, text: "Details"))
        if hasFirstStage { tabs.append(Tab(id: 1, text: "First stage")) }
        if hasCrew { tabs.append(Tab(id: 2, text: "Crew")) }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabLayout(tabs: tabs) {
                LaunchDetails(launch: launch).tag(0)
                
                if hasFirstStage {
                    LaunchDetailsCores().tag(1)
                }
                
                if hasCrew {
                    LaunchDetailsCrew().tag(2)
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    LaunchDetailsContainer(
        launch: LaunchItem(
            id: "id",
            upcoming: true,
            missionPatch: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/mission_patch_images/space2520x252_mission_patch_20221011205756.png",
            missionName: "Starlink Group 7-1",
            rocket: "Falcon 9",
            launchDate: "23 Oct 2023 - 07:04",
            launchDateUnix: 1,
            launchLocation: "Space Launch Complex 4E",
            launchLocationMap: "",
            launchLocationMapUrl: "",
            status: LaunchItem.Status(type: 1, name: "", description: ""),
            holdReason: "",
            failReason: "",
            description: "",
            type: "",
            orbit: "",
            webcast: [],
            webcastLive: false,
            firstStage: [],
            crew: []
        )
    )
}
