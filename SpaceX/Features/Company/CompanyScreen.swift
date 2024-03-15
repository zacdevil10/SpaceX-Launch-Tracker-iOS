//
//  CompanyScreen.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 03/03/2024.
//

import SwiftUI

struct CompanyScreen: View {
    
    @StateObject private var viewModel: CompanyViewModel = CompanyViewModel()
    
    var body: some View {
        CompanyContent(company: viewModel.company)
    }
}

struct CompanyContent : View {
    let company: ApiResult<Company>
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        Screen(result: company) { data in
            VStack(alignment: .leading) {
                Text(data.description)
                    .padding(.top, 24)
                
                Button {
                    openURL(URL(string: data.website)!)
                } label: {
                    Label("Website", systemImage: "link")
                        .frame(maxWidth: .infinity)
                }
                .tint(Color.materialPrimary)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
                .frame(maxWidth: .infinity)
                .padding(.top, 16)
                
                Button {
                    openURL(URL(string: data.wiki)!)
                } label: {
                    Label("Wikipedia", systemImage: "link")
                        .frame(maxWidth: .infinity)
                }
                .tint(Color.materialPrimary)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
                .frame(maxWidth: .infinity)
                .padding(.top, 16)
                
                LabelValue(label: "Founded", value: data.foundingYear)
                    .padding(.top, 16)
                
                LabelValue(label: "CEO", value: data.administrator)
                    .padding(.top, 16)
                
                Spacer()
            }
            .frame(maxHeight: .infinity)
            .padding(.horizontal, 16.0)
        }
    }
}

#Preview {
    CompanyContent(
        company: ApiResult.success(
            Company(
                id: 1,
                name: "Name",
                description: "Description",
                administrator: "Admin",
                foundingYear: "Founding Year",
                totalLaunchCount: 5,
                website: "",
                wiki: ""
            )
        )
    )
}
