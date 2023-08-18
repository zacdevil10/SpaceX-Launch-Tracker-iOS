//
//  LaunchListView.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 11/08/2023.
//

import SwiftUI

struct LaunchListView: View {
    @EnvironmentObject var provider: LaunchesProvider
    
    private var tabs: [Tab] = [
        Tab(id: 0, icon: "clock", text: "Upcoming"),
        Tab(id: 1, icon: "timer", text: "Previous")
    ]
    
    var body: some View {
        TabLayout(tabs: tabs) {
            Screen(result: provider.upcoming) { data in
                List {
                    HStack(spacing: 0) {
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
                        NavigationLink(destination: Text("Test")) {
                            EmptyView()
                        }
                        .frame(width: 0)
                        .opacity(0)
                    }

                    ForEach(data.dropFirst()) { launch in
                        launchView(launch: launch)
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(PlainListStyle())
                .refreshable {
                    await fetchUpcoming()
                }
            }
            .task {
                await fetchUpcoming()
            }
            .tag(0)

            Screen(result: ApiResult.success(provider.previous)) { data in
                List(data) { launch in
                    launchView(launch: launch)
                        .listRowSeparator(.hidden)
                        .onAppear() {
                            Task {
                                await fetchPreviousNext(launch: launch)
                            }
                        }
                }
                .listStyle(PlainListStyle())
                .refreshable {
                    await fetchPrevious()
                }
            }
            .task {
                if provider.previous.isEmpty {
                    await fetchPrevious()
                }
            }
            .tag(1)
        }
    }
    
    @ViewBuilder
    private func launchView(launch: LaunchResponse) -> some View {
        HStack(spacing: 0) {
            LaunchView(
                patch: launch.missionPatches?.first?.imageUrl,
                vehicle: launch.rocket?.configuration?.name,
                missionName: launch.mission?.name ?? launch.name,
                date: launch.net?.formatLaunchDate(),
                isReused: launch.rocket?.launcherStage?.first?.reused ?? false,
                landingPad: launch.rocket?.launcherStage?.first?.landing?.location?.abbrev
            )
            NavigationLink(destination: Text("Test")) {
                EmptyView()
            }
            .frame(width: 0)
            .opacity(0)
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
    
    func fetchPreviousNext(launch: LaunchResponse) async {
        do {
            try await provider.fetchPreviousNext(launch: launch)
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
