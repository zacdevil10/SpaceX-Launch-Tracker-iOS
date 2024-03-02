//
//  TabLayout.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 11/08/2023.
//

import SwiftUI

struct TabLayout<Content: View>: View {
    let tabs: [Tab]
    @State private var selectedTab = 0
    @ViewBuilder var content: Content
    
    init(tabs: [Tab] = [], @ViewBuilder content: () -> Content) {
        self.tabs = tabs
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    ForEach(tabs.indices, id: \.self) { index in
                        Button(action: {
                            withAnimation {
                                selectedTab = index
                            }
                        }) {
                            HStack(spacing: 4) {
                                if let icon = tabs[index].icon {
                                    Image(systemName: icon)
                                }
                                Text(tabs[index].text)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(Color.clear)
                            .foregroundColor(selectedTab == index ? Color.materialPrimary : Color.inverseSurface)
                        }
                    }
                }
                .frame(height: 48)
                
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: geometry.size.width / CGFloat(tabs.count), height: 3)
                        .foregroundColor(Color.materialPrimary)
                        .offset(x: CGFloat(selectedTab) * (geometry.size.width / CGFloat(tabs.count)))
                }
                .frame(height: 3.0)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.materialPrimary.opacity(0.3))
            }
            .background(Color.background)
            
            TabView(selection: $selectedTab) {
                content
            }
            .background(Color.background)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct Tab: Identifiable {
    let id: Int
    var icon: String? = nil
    let text: String
}

#Preview {
    TabLayout(tabs: [
        Tab(id: 0, icon: "clock", text: "Item 0"),
        Tab(id: 1, text: "Item 1"),
        Tab(id: 2, icon: "clock", text: "Item 2")
    ]) {
        Text("Item 0").tag(0)
        Text("Item 1").tag(1)
        Text("Item 2").tag(2)
    }
}
