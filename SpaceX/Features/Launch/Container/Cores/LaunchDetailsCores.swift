//
//  LaunchDetailsCores.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 18/08/2023.
//

import SwiftUI

struct LaunchDetailsCores: View {
    let firstStage: [FirstStageItem]
    
    var body: some View {
        let grouped = Dictionary(grouping: firstStage, by: { $0.type })
        
        List {
            if let item = firstStage.first, firstStage.count == 1 {
                FirstStage(
                    serial: item.serial,
                    description: item.landingDescription,
                    landingAttempt: item.landingAttempt,
                    landingLocation: item.landingLocation,
                    landingType: item.landingType,
                    previousFlight: item.previousFlight,
                    turnAroundTimeDays: item.turnAroundTimeDays,
                    totalFlights: item.totalFlights
                )
                .listRowBackground(Color.background)
                .listRowSeparator(.hidden)
            } else {
                ForEach(Array(grouped.keys)) { section in
                    if let items = grouped[section] {
                        Section(header: HStack {
                            Text(section.rawValue)
                                .font(.headline)
                                .foregroundColor(Color.onBackground)
                                .padding()

                                Spacer()
                        }
                        .background(Color.background)
                        .listRowInsets(EdgeInsets(
                            top: 0,
                            leading: 0,
                            bottom: 0,
                            trailing: 0))
                        ) {
                            ForEach(items) { item in
                                FirstStage(
                                    serial: item.serial,
                                    description: item.landingDescription,
                                    landingAttempt: item.landingAttempt,
                                    landingLocation: item.landingLocation,
                                    landingType: item.landingType,
                                    previousFlight: item.previousFlight,
                                    turnAroundTimeDays: item.turnAroundTimeDays,
                                    totalFlights: item.totalFlights
                                )
                                .listRowBackground(Color.background)
                                .listRowSeparator(.hidden)
                            }
                        }
                        .headerProminence(.increased)
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

#Preview("1 Item") {
    LaunchDetailsCores(
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
        ]
    )
}

#Preview("2 Items") {
    LaunchDetailsCores(
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
            ),
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
        ]
    )
}
