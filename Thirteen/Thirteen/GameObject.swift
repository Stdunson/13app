//
//  GameObject.swift
//  Thirteen
//
//  Created by Shavaughn on 12/25/24.
//

import Foundation
import SwiftUI

class GameObject{
    init(players: [Player]) {
        self.players = players
        self.numPlayers = players.count
        self.currPlay = []
        self.isFirstRound = true
    }
    
    func isRoundOver() -> Bool{
        var playersFolded: Int = 0
        for player in players{
            if player.hasFolded(){
                playersFolded += 1
            }
            if player.hasWon(){
                return true
            }
        }
        if playersFolded == numPlayers{
            return true
        }
        return false
    }

    func StartFirstRound() -> Int{
        var lowestCard: Card = Card(cardVal: 15, cardSuit: Suit.Heart)
        var lowestPlayer: Int = 0
        for p in 0..<players.count{
            for card in players[p].hand{
                if(card.cardVal < lowestCard.cardVal){
                    lowestCard = card
                    lowestPlayer = p
                    continue
                }else if(card.cardVal == lowestCard.cardVal && card.cardSuit < lowestCard.cardSuit){
                    lowestCard = card
                    lowestPlayer = p
                    continue
                }
            }
        }
        return lowestPlayer
    }
    
    //int StartNewRound(reset currplay, else return last round last folder)
    func StartNewRound(lastFolder: Int) -> Int{
        currPlay = []
        for player in players{
            player.unfold()
        }
        return lastFolder
    }
    
    func isLegalPlay(cardList: [Card]) -> Bool{
        var cards: [Card] = cardList
        var isValid: Bool = true
        var diffhasBeenZero: Bool = false
        //sorts cards && currplay
        if cards.count > 1{
            for i in 0..<cards.count - 1{
                for j in 0..<cards.count - 1 - i{
                    if(cards[j + 1].cardVal < cards[j].cardVal){
                        let temp: Card = cards[j]
                        cards[j] = cards[j + 1]
                        cards[j + 1] = temp
                    }else if(cards[j + 1].cardVal == cards[j].cardVal){
                        if(cards[j + 1].cardSuit < cards[j].cardSuit){
                            let temp: Card = cards[j]
                            cards[j] = cards[j + 1]
                            cards[j + 1] = temp
                        }
                    }
                }
            }
        }
        if currPlay.count > 1{
            for i in 0..<currPlay.count - 1{
                for j in 0..<currPlay.count - 1 - i{
                    if(currPlay[j + 1].cardVal < currPlay[j].cardVal){
                        let temp: Card = currPlay[j]
                        currPlay[j] = currPlay[j + 1]
                        currPlay[j + 1] = temp
                    }else if(currPlay[j + 1].cardVal == currPlay[j].cardVal){
                        if(currPlay[j + 1].cardSuit < currPlay[j].cardSuit){
                            let temp: Card = currPlay[j]
                            currPlay[j] = currPlay[j + 1]
                            currPlay[j + 1] = temp
                        }
                    }
                }
            }
        }
        if(cards.count == 1){
            diffhasBeenZero = true
        }else if(cards.count == 2){
            if(cards[0].cardVal != cards[1].cardVal){
                isValid = false
                print("Debug: illegal card distribution")
            }else{
                diffhasBeenZero = true
            }
        }else{
            for i in 0..<cards.count - 1{
                let diff: Int = cards[i + 1].cardVal - cards[i].cardVal
                if(diff == 0){
                    diffhasBeenZero = true
                }else if(diff > 1){
                    isValid = false
                    print("Debug: illegal card distribution")
                    break
                }
                if(diffhasBeenZero == true && diff > 0){
                    isValid = false
                    print("Debug: illegal card distribution")
                    break
                }
            }
        }
        if !currPlay.isEmpty && isValid == true{
            //assumes last play was valid
            var isStraight: Bool = true
            if currPlay.count < 3{
                isStraight = false
            }else if currPlay[1].cardVal - currPlay[0].cardVal == 0{
                isStraight = false
            }
            if(!isStraight && !diffhasBeenZero){
                isValid = false
                print("Debug: different play types")
            }else if(isStraight && diffhasBeenZero){
                isValid = false
                print("Debug: different play types")
            }
            if(cards.count != currPlay.count){
                isValid = false
                print("Debug: play not same length")
            }
            if(cards[cards.count - 1].cardVal < currPlay[currPlay.count - 1].cardVal){
                isValid = false
                print("Debug: last card not higher")
            }else if(cards[cards.count - 1].cardVal == currPlay[currPlay.count - 1].cardVal && cards[cards.count - 1].cardSuit < currPlay[currPlay.count - 1].cardSuit){
                isValid = false
                print("Debug: last card not higher")
            }
        }
        if isFirstRound == true{
            var lowestCard: Card = Card(cardVal: 15, cardSuit: Suit.Heart)
            for player in players{
                for card in player.hand{
                    if(card.cardVal < lowestCard.cardVal){
                        lowestCard = card
                    }else if(card.cardVal == lowestCard.cardVal && card.cardSuit < lowestCard.cardSuit){
                        lowestCard = card
                    }
                }
            }
            var lowestFound: Bool = false
            for card in cards{
                if card.cardVal == lowestCard.cardVal && card.cardSuit == lowestCard.cardSuit{
                    lowestFound = true
                }
            }
            if(!lowestFound){
                isValid = false
                print("lowest not found")
            }
        }
        
        return isValid;
    }
    
    func playCards(player: Player, cardList: [Card]){
        if isFirstRound {
            isFirstRound = false
        }
        currPlay = cardList
        
        // Collect indices to remove
        var indices: [Int] = []
        for i in 0..<player.hand.count {
            for card in cardList {
                if player.hand[i].cardVal == card.cardVal && player.hand[i].cardSuit == card.cardSuit {
                    indices.append(i)
                    break
                }
            }
        }
        for index in indices.sorted(by: >){
            player.removeCard(index: index)
        }
    }
    
    //bool isGameOver
    func isGameOver() -> Bool{
        for player in players{
            if player.hasWon(){
                return true
            }
        }
        return false
    }
    
    //void manageWins(returns index of winner)
    func manageWins() -> Int{
        var winner: Int = 0
        for p in 0..<players.count{
            if players[p].hasWon(){
                players[p].addWin()
                winner = p
            }else{
                players[p].addLoss()
            }
        }
        return winner
    }
    
    var players: [Player]
    var numPlayers: Int
    var currPlay: [Card]
    var isFirstRound: Bool
}
