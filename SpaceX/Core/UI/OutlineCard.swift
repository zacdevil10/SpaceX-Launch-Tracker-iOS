//
//  OutlineCard.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 11/08/2023.
//

import SwiftUI

struct OutlineCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.gray, lineWidth: 1)
            )
    }
}

extension View {
    func outlineCard() -> some View {
        modifier(OutlineCard())
    }
}
