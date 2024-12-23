//
//  GamePlay.swift
//  Thirteen
//
//  Created by Shavaughn on 12/22/24.
//

import SwiftUI

struct GamePlayLMult: View {
    let players: [Player]
    
    var numPlayers: Int{
        return players.count
    }
    
    var body: some View {
        NavigationView {
            Text(String(numPlayers))
        }
    }
}

#Preview {
    GamePlayLMult(players: [Player(pName: "Shavaughn"), Player(pName: "Amina")])
}
