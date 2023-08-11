//
//  LaunchExpandedView.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 11/08/2023.
//

import SwiftUI

struct LaunchExpandedView: View {
    let patch: String?
    let vehicle: String?
    let missionName: String?
    let date: String?
    let isReused: Bool
    let landingPad: String?
    let launchSite: String?
    let description: String?
    
    var body: some View {
        OutlineCard {
            HStack {
                Spacer()
                
                Text("T-42:13:23:55")
                    .font(.largeTitle)
                
                Spacer()
            }
            .padding([.top, .horizontal])
            
            LaunchView(
                patch: patch,
                vehicle: vehicle,
                missionName: missionName,
                date: date,
                isReused: isReused,
                landingPad: landingPad
            )
            .padding(.top, 8)
            .padding([.leading, .trailing], 16)
            
            if let launchSite = launchSite {
                LabelValueView(label: "Launch site:", value: launchSite)
                    .padding(.top, 8)
                    .padding(.horizontal, 16)
            }
            
            if let description = description {
                Text(description)
                    .padding(.top, 8)
                    .padding([.horizontal, .bottom], 16)
            }
        }
    }
}

struct LaunchExpandedView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchExpandedView(
            patch: nil,
            vehicle: "Falcon 9",
            missionName: "Nusantara Satu (PSN-6) / GTO-1 / Beresheet",
            date: "23 Oct 2019 - 12:53",
            isReused: true,
            landingPad: "JRTI",
            launchSite: "CCAFS SLC 40",
            description: "Description"
        )
    }
}
