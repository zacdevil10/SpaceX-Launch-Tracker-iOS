//
//  OutlineCard.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 11/08/2023.
//

import SwiftUI

struct OutlineCard<Content: View>: View {
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            content
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray, lineWidth: 1)
        )
    }
}

struct OutlineCard_Previews: PreviewProvider {
    static var previews: some View {
        OutlineCard {
            Text("Test")
            Text("Test")
        }
    }
}
