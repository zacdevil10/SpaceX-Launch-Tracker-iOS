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
        HStack(alignment: .top) {
            Text(label)
                .fontWeight(.bold)
            Spacer()
            Text(value).multilineTextAlignment(.trailing)
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

#Preview("Two lines") {
    LabelValue(
        label: "Label",
        value: "Value 1\nLonger Value 2"
    )
}
