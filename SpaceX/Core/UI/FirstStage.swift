//
//  FirstStage.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 11/02/2024.
//

import SwiftUI

struct FirstStage: View {
    let serial: String
    let description: String?
    let landingAttempt: Bool
    let landingLocation: String?
    let landingType: String?
    let previousFlight: String?
    let turnAroundTimeDays: Int?
    let totalFlights: Int?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("B1080")
                .font(.title)
            Divider()
            if let description = description{
                Text(description)
            }
            if landingAttempt {
                if let landingLocation = landingLocation {
                    LabelValue(label: "Landing Location", value: landingLocation)
                }
                if let landingType = landingType, landingType == "ASDS" || landingType == "RTLS" {
                    LabelValue(label: "Landing Type", value: landingType)
                }
            }
            if let previousFlight = previousFlight {
                LabelValue(label: "Previous Flight", value: previousFlight.replacingOccurrences(of: " | ", with: "\n"))
            }
            if let turnAroundTimeDays = turnAroundTimeDays {
                LabelValue(label: "Turn Around Time", value: String(turnAroundTimeDays))
            }
            if let totalFlights = totalFlights {
                LabelValue(label: "Total Flights", value: String(totalFlights))
            }
        }
        .padding(16)
        .outlineCard()
    }
}

#Preview {
    FirstStage(
        serial: "B1080",
        description: "The Falcon 9 first stage will attempt to land back at the launch site after this flight.",
        landingAttempt: true,
        landingLocation: "LZ-1",
        landingType: "RTLS",
        previousFlight: "Falcon 9 Block 5 | Starlink Group 6-24",
        turnAroundTimeDays: 87,
        totalFlights: 4
    )
}
