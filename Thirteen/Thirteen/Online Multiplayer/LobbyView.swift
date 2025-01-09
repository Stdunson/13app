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
        VStack{
            Text(player.getName())
            Text("\(playerAmt)")
        }
    }
}

#Preview {
    LobbyView(player: Player(pName: "Shavaughn"), playerAmt: 2)
}
