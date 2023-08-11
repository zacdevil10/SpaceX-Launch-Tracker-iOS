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
            LaunchListView()
                .environmentObject(launchesProvider)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LaunchesProvider())
    }
}
