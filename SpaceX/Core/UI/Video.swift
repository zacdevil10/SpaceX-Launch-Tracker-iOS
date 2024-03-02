//
//  VideoView.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 20/08/2023.
//

import SwiftUI

struct Video: View {
    let image: String?
    let title: String?
    
    var body: some View {
        VStack(spacing: 0) {
            if let image = image {
                AsyncImage(url: URL(string: image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(16/9, contentMode: .fit)
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.onSurface)
                        .aspectRatio(16/9, contentMode: .fit)
                }.cornerRadius(16)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.onSurface)
                    .aspectRatio(16/9, contentMode: .fit)
            }
            VStack {
                if let title = title {
                    Text(title)
                        .lineLimit(2...)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.trailing, 16)
                }
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Text("Watch")
                            .padding(.horizontal, 16)
                    }
                    .tint(Color.materialPrimary)
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .controlSize(.large)
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    Video(
        image: "https://i.ytimg.com/vi/agYuEAkEljw/maxresdefault_live.jpg",
        title: "Starlink Mission"
    )
}

#Preview("No Image") {
    Video(
        image: nil,
        title: "Starlink Mission"
    )
}
