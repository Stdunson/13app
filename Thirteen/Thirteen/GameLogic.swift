//
//  GameLogic.swift
//  Thirteen
//
//  Created by Shavaughn on 11/22/24.
//

import Foundation
import SwiftUI

class gameLogic{
    //public
    init() {
        self.deck = []
        self.isShuffled = false
    }
    func createDeck(){
        for num in 0...12{
            for suit in Suit.allCases{
                deck.append(Card(cardNum: Val[num], cardSuit: suit))
            }
        }
    }

    func shuffleDeck(){
        var tempDeck = deck
        var numCards = 52
        while(!tempDeck.isEmpty){
            var randInt = Int.random(in: 0..<numCards)
            deck[numCards - 1] = tempDeck[randInt]
            tempDeck.remove(at: randInt)
        }
        isShuffled = true
    }
    
    func dealDeck(numPlayers: Int) -> [[Card]]{
        if(numPlayers <= 4 && numPlayers >= 2){
            return []
        }else{
            return []
        }
    }
    //private
    private var deck: [Card]
    private var isShuffled: Bool
}
