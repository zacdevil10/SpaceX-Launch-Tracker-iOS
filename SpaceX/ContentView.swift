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
                }
                .onAppear() {
                    let surfaceColorAtElevation = UIColor(Color.surface) * 0.85 + UIColor(Color.surfaceTint) * 0.15
                    
                    UITabBar.appearance().isTranslucent = false
                    UITabBar.appearance().backgroundColor = surfaceColorAtElevation
                }
                .tint(Color.onSurface)
            }
        }
    }
}

func addColor(_ color1: UIColor, with color2: UIColor) -> UIColor {
    var (r1, g1, b1, a1) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
    var (r2, g2, b2, a2) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))

    color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
    color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

    // add the components, but don't let them go above 1.0
    return UIColor(red: min(r1 + r2, 1), green: min(g1 + g2, 1), blue: min(b1 + b2, 1), alpha: (a1 + a2) / 2)
}

func multiplyColor(_ color: UIColor, by multiplier: CGFloat) -> UIColor {
    var (r, g, b, a) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
    color.getRed(&r, green: &g, blue: &b, alpha: &a)
    return UIColor(red: r * multiplier, green: g * multiplier, blue: b * multiplier, alpha: a)
}

func +(color1: UIColor, color2: UIColor) -> UIColor {
    return addColor(color1, with: color2)
}

func *(color: UIColor, multiplier: Double) -> UIColor {
    return multiplyColor(color, by: CGFloat(multiplier))
}

#Preview {
    ContentView()
}
