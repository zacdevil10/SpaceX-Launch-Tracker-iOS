//
//  Screen.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 11/08/2023.
//

import SwiftUI

struct Screen<T, Content: View>: View {
    let result: ApiResult<T>
    let content: (T) -> Content
    
    @ViewBuilder
    var body: some View {
        ZStack {
            switch result {
            case .success(let data):
                content(data)
            case .pending:
                ProgressView()
            case .error(let error):
                Text(error.localizedDescription)
            }
        }
        .frame(maxHeight: .infinity)
        .frame(maxWidth: .infinity)
        .background(Color.background)
    }
}

#Preview {
    Screen(result: ApiResult<Any>.pending) { data in
        Text("Preview")
    }
}
