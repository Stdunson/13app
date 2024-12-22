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
    //implement after defining player
    func deal(){
        
    }
    
    var cards: [Card]
}
