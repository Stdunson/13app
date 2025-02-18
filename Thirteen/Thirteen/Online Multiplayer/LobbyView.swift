//
//  LobbyView.swift
//  Thirteen
//
//  Created by Shavaughn on 1/9/25.
//

import SwiftUI

struct LobbyView: View {
    let player: Player
    let playerAmt: Int
    var body: some View {
        NavigationStack{
            VStack{
                Text("Coming soon")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LobbyView(player: Player(pName: "Shavaughn"), playerAmt: 2)
}
