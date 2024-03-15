//
//  ContentView.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 10/08/2023.
//

import SwiftUI

struct ContentView: View {
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
                    
                    CompanyScreen()
                        .tabItem {
                            Label("Company", systemImage: "building.2")
                        }
                }
                .onAppear {
                    let tabBarAppearance = UITabBarAppearance()
                    tabBarAppearance.configureWithOpaqueBackground()
                    UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                }
                .tint(Color.onSurface)
            }
        }
    }
}

#Preview {
    ContentView()
}
