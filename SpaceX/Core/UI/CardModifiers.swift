//
//  OutlineCard.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 11/08/2023.
//

import SwiftUI

struct ElevatedCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.surfaceVariant)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.2), radius: 4)
    }
}

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
    func elevatedCard() -> some View {
        modifier(ElevatedCard())
    }
    
    func outlineCard() -> some View {
        modifier(OutlineCard())
    }
}
