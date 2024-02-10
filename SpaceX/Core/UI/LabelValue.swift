//
//  LabelValueView.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 11/08/2023.
//

import SwiftUI

struct LabelValue: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .fontWeight(.bold)
            Spacer()
            Text(value)
        }
        .padding(.vertical, 4.0)
    }
}

#Preview {
    LabelValue(
        label: "Label",
        value: "Value"
    )
}
