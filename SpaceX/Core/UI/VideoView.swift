//
//  VideoView.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 20/08/2023.
//

import SwiftUI

struct VideoView: View {
    let image: String?
    let title: String
    
    var body: some View {
        HStack(spacing: 0) {
            if let image = image {
                AsyncImage(url: URL(string: image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150)
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.gray.opacity(0.5))
                        .frame(width: 150, height: 150)
                        .clipped()
                }.cornerRadius(16)
            }
            VStack {
                Text(title)
                    .lineLimit(2...)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.trailing, 16)
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Text("Watch")
                            .padding(.horizontal, 16)
                    }
                    .tint(.accentColor)
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

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(
            image: "https://i.ytimg.com/vi/agYuEAkEljw/maxresdefault_live.jpg",
            title: "Starlink Mission"
        )
    }
}
