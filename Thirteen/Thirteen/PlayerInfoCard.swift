//
//  PlayerInfoCard.swift
//  Thirteen
//
//  Created by Shavaughn on 12/31/24.
//

import SwiftUI

struct PlayerInfoCard: View {
    let player: Player
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 100, height: 100)
                .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black, lineWidth: 3) )
                .foregroundStyle(.gray)
                .background(.gray)
            VStack{
                Text("\(player.getName())")
                    .fontWeight(.semibold)
                    .frame(width: 100)
                    .multilineTextAlignment(.center)
                Text("\(player.getCardAmt()) cards")
                Text("\(player.getWins()) wins")
            }
        }
    }
}

#Preview {
    PlayerInfoCard(player: Player(pName: "T"))
}
