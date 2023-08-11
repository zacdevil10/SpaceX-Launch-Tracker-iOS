//
//  LaunchListView.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 11/08/2023.
//

import SwiftUI

struct LaunchListView: View {
    @EnvironmentObject var provider: LaunchesProvider
    
    var body: some View {
        launchList(result: provider.upcoming)
            .task {
                await fetchUpcoming()
            }
        
    }
    
    @ViewBuilder
    private func launchList(result: ApiResult<[LaunchResponse]>) -> some View {
        Screen(result: result) { data in
            List {
                LaunchExpandedView(
                    patch: data.first?.missionPatches?.first?.imageUrl,
                    vehicle: data.first?.rocket?.configuration?.name,
                    missionName: data.first?.mission?.name ?? data.first?.name,
                    date: data.first?.net?.formatLaunchDate(),
                    isReused: data.first?.rocket?.launcherStage?.first?.reused ?? false,
                    landingPad: data.first?.rocket?.launcherStage?.first?.landing?.location?.abbrev,
                    launchSite: data.first?.pad?.name,
                    description: data.first?.mission?.description
                )
                
                ForEach(data.dropFirst()) { launch in
                    LaunchView(
                        patch: launch.missionPatches?.first?.imageUrl,
                        vehicle: launch.rocket?.configuration?.name,
                        missionName: launch.mission?.name ?? data.first?.name,
                        date: launch.net?.formatLaunchDate(),
                        isReused: launch.rocket?.launcherStage?.first?.reused ?? false,
                        landingPad: launch.rocket?.launcherStage?.first?.landing?.location?.abbrev
                    )
                }
            }
        }
    }
}

extension LaunchListView {
    func fetchUpcoming() async {
        do {
            try await provider.fetchUpcoming()
        } catch {
            
        }
    }
    
    func fetchPrevious() async {
        do {
            try await provider.fetchPrevious()
        } catch {
            
        }
    }
}

struct LaunchListView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchListView()
            .environmentObject(LaunchesProvider())
    }
}
