//
//  HowToPlay.swift
//  Thirteen
//
//  Created by Shavaughn on 12/26/24.
//

import SwiftUI

var setup: String = """
 1. Shuffle the deck and deal 13 cards to each player. This game can have 2-4 players.
 2. Whoever has the lowest card will play first. This will usually be the 3 of spades.
"""

var cards: String = """
 1. Suit Order(Low to High): Spade, Club, Diamond, Heart
 2. Card Order(Low to High): 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace, 2
"""

var gameplay: String = """
 1. Play the first turn of the round. If this is the first turn of the game, the lowest card must be included in the play. Plays can have two formats: up to 4 of a kind or at least 3 straight. If a player has all 4 2s or 13 straight, they automatically win the game.
 2. After the first turn has been played, players will take turns playing on top of that card. To play on top of it, you must play the same pattern as the first turn, and the highest card in the new play must be above the highest card in the old play. If you can no longer play on top of the previous play, you must fold. Once you fold, you cannot play any cards for the rest of the round. You can fold at any time you want.
 3.  Once every player has folded, whoever the last player to fold was will start the next round. This time, any pattern can be played, there is no requirement to include the lowest card. Keep repeating step 1 & 2 until a player runs out of cards. Whoever this player is has won the game.
"""

var controls: String = """
Singleplayer:
 - Select Cards: Tap each card you'd like to select
 - Play Cards: Tap play cards button
 - Fold: Tap fold button
Local Multiplayer:
 - Show Hand: Tap "Show Hand" button
 - Select Cards: Tap each card you'd like to select
 - Play Cards: Tap play cards button
 - Fold: Tap fold button
Online Multiplayer:
 - Coming Soon...
"""

struct HowToPlay: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("How To Play 13")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                ScrollView {
                    Text("Cards")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text(cards)
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                    Text("Setup")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text(setup)
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                    Text("Gameplay")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text(gameplay)
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                    Text("Controls")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text(controls)
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                }
            }
        }
    }
}

#Preview {
    HowToPlay()
}
