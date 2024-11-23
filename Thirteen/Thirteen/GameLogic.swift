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
        self.players = []
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
        let numCards = 52
        while(!tempDeck.isEmpty){
            let randInt = Int.random(in: 0..<numCards)
            deck[numCards - 1] = tempDeck[randInt]
            tempDeck.remove(at: randInt)
        }
        isShuffled = true
    }
    func dealDeck(numPlayers: Int) -> [[Card]]{
        if(isShuffled){
            isShuffled = false
            var deal: [[Card]] = []
            if(numPlayers <= 4 && numPlayers >= 2){
                for hands in 0..<4{
                    var temp: [Card] = []
                    for cards in 0..<13{
                        temp.append(deck[(hands*13)+cards])
                    }
                    deal.append(temp)
                }
            }
            return deal
        }else{
            return []
        }
    }
    func playRound(lastFolder: Player){
        
    }
    //private
    private var deck: [Card]
    private var isShuffled: Bool
    private var players: [Player]
}
