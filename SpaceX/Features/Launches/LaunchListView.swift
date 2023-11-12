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
                    if let first = data.first {
                        HStack(spacing: 0) {
                            LaunchExpandedView(
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
                            NavigationLink(destination: LaunchDetailsContainer(launch: data.first!)) {
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
                .refreshable {
                    await fetchUpcoming()
                }
            }
            .task {
                if case .pending = provider.upcoming {
                    await fetchUpcoming()
                }
            }
            .tag(0)

            Screen(result: provider.previous) { data in
                List {
                    ForEach(data) { launch in
                        launchView(launch: launch)
                            .listRowSeparator(.hidden)
                            .onAppear() {
                                Task {
                                    await fetchPreviousNext(launch: launch)
                                }
                            }
                    }
                    
                    if case .success = provider.previous {
                        pagingIndicator
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(PlainListStyle())
                .refreshable {
                    await fetchPrevious()
                }
            }
            .task {
                if case .pending = provider.previous {
                    await fetchPrevious()
                }
            }
            .tag(1)
        }
    }
    
    @ViewBuilder
    private func launchView(launch: LaunchItem) -> some View {
        HStack(spacing: 0) {
            LaunchView(
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
            switch provider.previousLoadState {
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
    
    func fetchPreviousNext(launch: LaunchItem) async {
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
