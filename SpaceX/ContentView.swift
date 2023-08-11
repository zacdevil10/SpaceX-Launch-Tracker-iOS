//
//  ContentView.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 10/08/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var launchesProvider = LaunchesProvider()
    
    var body: some View {
        VStack {
            NavigationStack {
                TabView {
                    LaunchListView()
                        .environmentObject(launchesProvider)
                        .tabItem {
                            Label("Launches", systemImage: "calendar")
                        }
                }.onAppear {
                    let tabBarAppearance = UITabBarAppearance()
                    tabBarAppearance.configureWithOpaqueBackground()
                    UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LaunchesProvider())
    }
}
