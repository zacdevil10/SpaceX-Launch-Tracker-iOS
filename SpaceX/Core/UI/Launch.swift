//
//  LaunchView.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 11/08/2023.
//

import SwiftUI

struct Launch: View {
    let patch: String?
    let vehicle: String?
    let missionName: String?
    let date: String?
    let isReused: Bool
    let landingPad: String?
    
    var body: some View {
        HStack {
            if let missionPatch = patch {
                AsyncImage(url: URL(string: missionPatch), content: view)
                    .frame(width: 64.0, height: 64.0)
            } else {
                Image(systemName: "photo.circle")
                    .resizable()
                    .foregroundColor(Color.materialPrimary)
                    .padding(.all, 4.0)
                    .frame(width: 64.0, height: 64.0)
            }
            VStack(alignment: .leading) {
                Spacer()
                
                Text(missionName ?? "")
                    .lineLimit(1)
                    .padding(.top, 8.0)
                    .font(.headline)
                    .foregroundStyle(Color.onSurface)
                
                Spacer()
                
                if let launchDate = date {
                    Text(launchDate)
                        .font(.system(size: 12))
                        .padding(.bottom, 8.0)
                        .foregroundStyle(Color.onSurface)
                }
                
                Spacer()
            }
            .frame(maxHeight: .infinity)
            Spacer()
            VStack(alignment: .trailing) {
                Spacer()
                
                Text(vehicle ?? "")
                    .font(.caption)
                    .padding(.top, 8.0)
                    .foregroundStyle(Color.onSurface)
                
                Spacer()
                
                if isReused {
                    Text("REUSED")
                        .font(.caption)
                        .foregroundStyle(Color.materialSecondary)
                } else {
                    Text("")
                }
                
                Spacer()
                
                if landingPad != "N/A" {
                    Text(landingPad ?? "")
                        .font(.caption)
                        .foregroundStyle(Color.materialSecondary)
                        .padding(.bottom, 8.0)
                } else {
                    Text("")
                }
                
                Spacer()
            }
        }
        .fixedSize(horizontal: false, vertical: true)
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
        case .failure:
            Image(systemName: "photo.circle")
                .resizable()
                .foregroundColor(Color.materialPrimary)
                .padding(.all, 4.0)
                .frame(width: 64.0, height: 64.0)
        @unknown default:
            Text("Unknown")
                .foregroundColor(Color.onSurface)
        }
    }
}

#Preview {
    Launch(patch: nil, vehicle: "Falcon 9", missionName: "Nusantara Satu (PSN-6) / GTO-1 / Beresheet", date: "23 Oct 2019 - 12:53", isReused: false, landingPad: "JRTI")
}

#Preview("Reused") {
    Launch(patch: nil, vehicle: "Falcon 9", missionName: "Nusantara Satu (PSN-6) / GTO-1 / Beresheet", date: "23 Oct 2019 - 12:53", isReused: true, landingPad: "JRTI")
}
