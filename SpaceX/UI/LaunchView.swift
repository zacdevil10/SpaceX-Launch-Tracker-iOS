//
//  LaunchView.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 11/08/2023.
//

import SwiftUI

struct LaunchView: View {
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
                    .foregroundColor(Color.gray.opacity(0.5))
                    .padding(.all, 4.0)
                    .frame(width: 64.0, height: 64.0)
            }
            VStack(alignment: .leading) {
                Text(missionName ?? "")
                    .lineLimit(1)
                    .padding(.top, 8.0)
                
                Spacer()
                
                if let launchDate = date {
                    Text(launchDate)
                        .font(.system(size: 12))
                        .padding(.bottom, 8.0)
                }
            }
            .frame(maxHeight: .infinity)
            Spacer()
            VStack(alignment: .trailing) {
                Text(vehicle ?? "")
                    .font(.caption)
                    .padding(.top, 8.0)
                
                Spacer()
                
                if isReused {
                    Text("REUSED")
                        .font(.caption)
                        .foregroundColor(Color.accentColor)
                } else {
                    Text("")
                }
                
                Spacer()
                
                if landingPad != "N/A" {
                    Text(landingPad ?? "")
                        .font(.caption)
                        .foregroundColor(Color.accentColor)
                        .padding(.bottom, 8.0)
                }
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
                .foregroundColor(Color.gray.opacity(0.5))
                .padding(.all, 4.0)
                .frame(width: 64.0, height: 64.0)
        @unknown default:
            Text("Unknown")
                .foregroundColor(.gray)
        }
    }
}

struct LaunchViewReused_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(patch: nil, vehicle: "Falcon 9", missionName: "Nusantara Satu (PSN-6) / GTO-1 / Beresheet", date: "23 Oct 2019 - 12:53", isReused: true, landingPad: "JRTI")
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(patch: nil, vehicle: "Falcon 9", missionName: "Nusantara Satu (PSN-6) / GTO-1 / Beresheet", date: "23 Oct 2019 - 12:53", isReused: false, landingPad: "JRTI")
    }
}
