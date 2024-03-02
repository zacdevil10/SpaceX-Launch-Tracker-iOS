//
//  LaunchDetailsCrew.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 18/08/2023.
//

import SwiftUI

struct LaunchDetailsCrew: View {
    let crew: [CrewItem]
    
    @State var expandedPosition: Int = -1
    
    var body: some View {
        GeometryReader { geometry in
            List {
                ForEach(crew.indices, id: \.self) { index in
                    let astronaut: CrewItem = crew[index]
                    Astronaut(
                        image: astronaut.image,
                        role: astronaut.role,
                        title: astronaut.name,
                        agency: astronaut.agency,
                        status: astronaut.status.rawValue,
                        firstFlight: astronaut.firstFlight,
                        description: astronaut.bio,
                        expanded: expandedPosition == index,
                        onClick: {
                            if expandedPosition != index {
                                expandedPosition = index
                            } else {
                                expandedPosition = -1
                            }
                        },
                        width: geometry.size.width
                    )
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

#Preview {
    LaunchDetailsCrew(
        crew: [
            CrewItem(
                id: "1",
                name: "Name",
                status: CrewStatus.ACTIVE,
                agency: "Agency",
                bio: "Bio",
                image: nil,
                role: "Role",
                firstFlight: "First Flight"
            ),
            CrewItem(
                id: "2",
                name: "Name",
                status: CrewStatus.ACTIVE,
                agency: "Agency",
                bio: "Bio",
                image: nil,
                role: "Role",
                firstFlight: "First Flight"
            )
        ],
        expandedPosition: 0
    )
}
