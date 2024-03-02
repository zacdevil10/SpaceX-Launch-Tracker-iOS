//
//  Astronaut.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 02/03/2024.
//

import SwiftUI

struct Astronaut: View {
    let image: String?
    let role: String?
    let title: String?
    let agency: String?
    let status: String?
    let firstFlight: String?
    let description: String?
    let expanded: Bool
    let onClick: () -> Void
    
    var width: CGFloat
    
    var body: some View {
        VStack {
            HStack {
                if let image = image {
                    AsyncImage(url: URL(string: image), content: view)
                        .frame(width: width * 0.3)
                        .fixedSize()
                } else {
                    Image(systemName: "photo.circle")
                        .resizable()
                        .foregroundStyle(Color.onSurfaceVariant)
                        .padding(.all, 4.0)
                        .frame(width: width * 0.3)
                }
                VStack(alignment: .leading) {
                    if let role = role {
                        Text(role)
                            .font(.caption)
                            .foregroundStyle(Color.onSurfaceVariant)
                            .padding(.trailing, 16.0)
                    }
                    if let title = title {
                        Text(title)
                            .font(.title3)
                            .foregroundStyle(Color.onSurfaceVariant)
                            .padding(.top, 8.0)
                            .padding(.trailing, 16.0)
                    }
                    if let agency = agency {
                        Text(agency)
                            .font(.caption)
                            .foregroundStyle(Color.onSurfaceVariant)
                            .padding(.top, 8.0)
                            .padding(.trailing, 16.0)
                    }
                    HStack {
                        Spacer()
                        Image(systemName: "chevron.down")
                            .padding(.top, 8.0)
                            .padding(.bottom, 8.0)
                            .padding(.trailing, 16.0)
                    }
                }
                .padding(.top, 16.0)
                .padding(.leading, 16.0)
                Spacer()
            }
            if expanded {
                VStack(alignment: .leading) {
                    if let status = status {
                        LabelValue(label: "Status", value: status)
                            .padding(.horizontal, 16.0)
                            .padding(.top, 8.0)
                    }
                    if let firstFlight = firstFlight {
                        LabelValue(label: "First flight", value: firstFlight)
                            .padding(.horizontal, 16.0)
                            .padding(.top, 8.0)
                    }
                    if let description = description {
                        Text(description)
                            .padding(.all, 16.0)
                    }
                }
            }
        }
        .elevatedCard()
        .onTapGesture {
            withAnimation (.spring(response: 0.6, dampingFraction: 0.8)) {
                onClick()
            }
        }
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
                .scaledToFit()
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 16.0))
        case .failure:
            Image(systemName: "photo.circle")
                .resizable()
                .foregroundColor(Color.onSurfaceVariant)
                .padding(.all, 4.0)
                .frame(width: width * 0.3)
        @unknown default:
            Text("Unknown")
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    Astronaut(
        image: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/astronaut_images/matthew2520dominick_image_20200110160726.jpeg",
        role: "Role",
        title: "Title",
        agency: "Agency",
        status: "Status",
        firstFlight: "First Flight",
        description: "Description",
        expanded: false,
        onClick: {},
        width: CGFloat(100)
    )
}

#Preview("Expanded") {
    Astronaut(
        image: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/astronaut_images/matthew2520dominick_image_20200110160726.jpeg",
        role: "Role",
        title: "Title",
        agency: "Agency",
        status: "Status",
        firstFlight: "First Flight",
        description: "Description",
        expanded: true,
        onClick: {},
        width: CGFloat(100)
    )
}
