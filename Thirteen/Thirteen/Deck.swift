//
//  Deck.swift
//  Thirteen
//
//  Created by Shavaughn on 12/22/24.
//

import Foundation
import SwiftUI

class Deck{
    init() {
        var deckCards: [Card] = []
        for suit in Suit.allCases{
            for j in 0...12{
                deckCards.append(Card(cardVal: j + 1, cardSuit: suit))
            }
        }
        self.cards = deckCards
    }
    
    func shuffle(){
        for i in stride(from: 51, to: 1, by: -1){
            let j: Int = Int.random(in: 0...i)
            let temp: Card = cards[i]
            cards[i] = cards[j]
            cards[j] = temp
        }
    }

    func deal(players: [Player]){
        shuffle()
        let playerCount: Int = players.count
        if playerCount > 4 || playerCount < 2{
            print("error")
            return
        }
        for i in 0..<playerCount{
            var temphand: [Card] = []
            for c in 0..<13{
                temphand.append(cards[i*13 + c])
            }
            players[i].setHand(newHand: temphand)
        }
    }
    
    var cards: [Card]
}
