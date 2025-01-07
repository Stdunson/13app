//
//  HowToPlay.swift
//  Thirteen
//
//  Created by Shavaughn on 12/26/24.
//

import SwiftUI

struct HowToPlay: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("How To Play 13")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Setup")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Gameplay")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Controls")
                    .font(.title)
                    .fontWeight(.semibold)
            }
        }
    }
}

#Preview {
    HowToPlay()
}
