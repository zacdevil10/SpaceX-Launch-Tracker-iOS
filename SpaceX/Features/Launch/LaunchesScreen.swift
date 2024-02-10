//
//  LaunchListView.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 11/08/2023.
//

import SwiftUI

struct LaunchesScreen: View {

    @StateObject private var provider: LaunchesViewModel = LaunchesViewModel()
    
    var body: some View {
        LaunchesContent(
            upcoming: provider.upcoming,
            previous: provider.previous,
            fetchPreviousNext: { (id) -> Void in
                await provider.fetchPreviousNext(id: id)
            },
            previousLoadState: provider.previousLoadState
        )
    }
}

struct LaunchesContent : View {
    let upcoming: ApiResult<[LaunchItem]>
    let previous: ApiResult<[LaunchItem]>

    let fetchPreviousNext: (String) async -> Void
    
    let previousLoadState: LoadState

    var tabs: [Tab] = [
        Tab(id: 0, icon: "clock", text: "Upcoming"),
        Tab(id: 1, icon: "timer", text: "Previous")
    ]

    var body: some View {
        TabLayout(tabs: tabs) {
            Screen(result: upcoming) { data in
                List {
                    if let first = data.first {
                        HStack(spacing: 0) {
                            LaunchExpanded(
                                patch: first.missionPatch,
                                vehicle: first.rocket,
                                missionName: first.missionName,
                                date: first.launchDate,
                                isReused: first.isReused(),
                                landingPad: first.landingPad(),
                                launchSite: first.launchLocation,
                                description: first.description,
                                countdown: first.countdown
                            )
                            NavigationLink(destination: LaunchDetailsContainer(launch: first)) {
                                EmptyView()
                            }
                            .frame(width: 0)
                            .opacity(0)
                        }
                    }

                    ForEach(data.dropFirst()) { launch in
                        launchView(launch: launch)
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .tag(0)

            Screen(result: previous) { data in
                List {
                    ForEach(data) { launch in
                        launchView(launch: launch)
                            .listRowSeparator(.hidden)
                            .onAppear() {
                                Task {
                                    await fetchPreviousNext(launch.id)
                                }
                            }
                    }
                    
                    if case .success = previous {
                        pagingIndicator
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .tag(1)
        }
    }
    
    @ViewBuilder
    private func launchView(launch: LaunchItem) -> some View {
        HStack(spacing: 0) {
            Launch(
                patch: launch.missionPatch,
                vehicle: launch.rocket,
                missionName: launch.missionName,
                date: launch.launchDate,
                isReused: launch.isReused(),
                landingPad: launch.landingPad()
            )
            NavigationLink(destination: LaunchDetailsContainer(launch: launch)) {
                EmptyView()
            }
            .frame(width: 0)
            .opacity(0)
        }
    }
    
    var pagingIndicator: some View {
        HStack(alignment: .center) {
            switch previousLoadState {
            case .success:
                EmptyView()
            case .pending:
                Spacer()
                ProgressView()
                Spacer()
            case .error(_):
                Text("Error")
            }
        }
    }
}

struct LaunchListView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchesScreen()
    }
}
