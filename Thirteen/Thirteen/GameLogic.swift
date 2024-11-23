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
        self.isWon = false
        self.winner = Player()
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
    func dealDeck() -> [[Card]]{
        if(isShuffled){
            isShuffled = false
            let numPlayers = players.count
            var deal: [[Card]] = []
            if(numPlayers <= 4 && numPlayers >= 2){
                for hands in 0..<numPlayers{
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
    func playFirstRound(numPlayers: Int) -> Player{
        //initialize return value
        var lastFolder: Player = Player()
        //initialize current player and card choice values
        var currPlayer: Player = Player()
        var currChoice: [Card] = []
        //Shuffle Deck
        if(!isShuffled){
            createDeck()
            shuffleDeck()
        }
        //Deal Hands
        let hands: [[Card]] = dealDeck()
        for num in 0..<players.count{
            players[num].hand = hands[num]
        }
        //find lowest value in any player's hand
        var lowestPlayerIndex: Int = 0
        var lowestCardIndex: Int = 0
        var lowestValFound: Int = 12
        var lowestSuitFound: Int = 3
        for hands in 0..<players.count{
            for card in 0..<players[hands].hand.count{
                let currVal: Int = Val.firstIndex(of: players[hands].hand[card].cardNum)!
                let currSuit: Int = Suit.allCases.firstIndex(of: players[hands].hand[card].cardSuit)!
                if(currVal > lowestValFound){
                    continue
                }
                if(currSuit > lowestSuitFound){
                    continue
                }
                lowestCardIndex = card
                lowestPlayerIndex = hands
            }
        }
        //have first player set pattern w/ first play + check if legal
        currPlayer = players[lowestPlayerIndex]
        
        //restrict other plays to that pattern
        //figure out who folds last + return for start next
        return lastFolder
    }
    func playRound(numPlayers: Int) -> Player{
        //initialize return value
        var lastFolder: Player = Player()
        //have first player set pattern w/ first play + check if legal + check if out
        //restrict other plays to that pattern + check if any players run out
        //figure out who folds last + return for start next
        return lastFolder
    }
    //private
    private var deck: [Card]
    private var isShuffled: Bool
    private var isWon: Bool
    private var players: [Player]
    private var winner: Player
}
