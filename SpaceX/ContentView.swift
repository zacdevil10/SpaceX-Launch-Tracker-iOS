//
//  ContentView.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 10/08/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var launchesProvider = LaunchesViewModel()
    
    var body: some View {
        VStack {
            NavigationStack {
                TabView {
                    LaunchesScreen()
                        .tabItem {
                            Label("Launches", systemImage: "calendar")
                        }
                    
                    NewsScreen()
                        .tabItem {
                            Label("News", systemImage: "newspaper")
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
    }
}
