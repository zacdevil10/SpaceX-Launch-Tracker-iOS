//
//  CountdownView.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 28/08/2023.
//

import SwiftUI

struct Countdown: View {
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var countdown: () -> String?
    
    @State var value: String = ""
    
    var body: some View {
        Text("\(value)")
            .onReceive(timer) { _ in
                self.value = countdown() ?? ""
            }
    }
}

#Preview {
    Countdown(
        countdown: { "T-23:15:12:36" }
    )
}
