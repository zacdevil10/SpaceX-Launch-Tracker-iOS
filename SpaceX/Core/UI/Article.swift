//
//  Article.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 10/02/2024.
//

import SwiftUI

struct Article: View {
    let title: String
    let url: String
    let image: String
    let site: String
    let published: String?
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: image)) { image in
                image
                    .resizable()
                    .aspectRatio(16/9, contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .clipped()
            } placeholder: {
                Image(systemName: "newspaper")
                    .resizable()
                    .aspectRatio(16/9, contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .foregroundColor(Color.gray.opacity(0.5))
                
            }
            .cornerRadius(16)
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(site)
                        .font(.caption)
                    Text(title)
                        .font(.headline)
                    if let published = published{
                        Text(published)
                            .font(.caption)
                    }
                }
                Spacer()
            }.padding(.top, 8)
        }.padding(.horizontal, 16)
    }
}

#Preview {
    Article(
        title: "Title",
        url: "",
        image: "https://i.ytimg.com/vi/agYuEAkEljw/maxresdefault_live.jpg",
        site: "Site",
        published: "Published"
    )
}
