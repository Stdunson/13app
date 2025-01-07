//
//  Player.swift
//  Thirteen
//
//  Created by Shavaughn on 12/22/24.
//

import Foundation
import SwiftUI

class Player: Identifiable{
    init(pName: String){
        hand = []
        wincount = 0
        losscount = 0
        folded = false
        name = pName
        cardPlayed = Array(repeating: false, count: 13)
    }
    init(){
        hand = []
        wincount = 0
        losscount = 0
        folded = false
        name = "Unnamed person"
        cardPlayed = Array(repeating: false, count: 13)
    }
    
    func setHand(newHand: [Card]){
        hand = []
        for i in 0...12{
            hand.append(newHand[i])
        }
    }
    func getCard(index: Int) -> Card{
        if(index >= 0 && index < hand.count){
            return hand[index]
        }else{
            print("There was an error")
            return hand[0]
        }
    }
    func removeCard(index: Int){
        if(index >= 0 && index < hand.count){
            hand.remove(at: index)
        }
    }
    func hasWon() -> Bool{
        if !hand.isEmpty{
            return false
        }
        return true
    }
    func hasFolded() -> Bool{
        return folded
    }
    func fold(){
        folded = true
    }
    func unfold(){
        folded = false
    }
    func getWins() -> Int{
        return wincount
    }
    func getLosses() -> Int{
        return losscount
    }
    func getName() -> String{
        return name
    }
    func equals(otherPlayer: Player) -> Bool{
        if(wincount != otherPlayer.getWins()){
            return false
        }
        if(losscount != otherPlayer.getLosses()){
            return false
        }
        if(name != otherPlayer.getName()){
            return false
        }
        return true
    }
    func addWin(){
        wincount += 1
    }
    func addLoss(){
        losscount += 1
    }
    func hasAllTwos() -> Bool{
        var amt2s: Int = 0
        for i in 0...12{
            if(hand[i].cardVal == 13){
                amt2s += 1
            }
        }
        return amt2s == 4
    }
    func has13Straight() -> Bool{
        var cardsHad: [Card] = []
        cardsHad.append(hand[0])
        for i in 0...12{
            for j in cardsHad{
                if(j.cardVal == hand[i].cardVal){
                    return false
                }
            }
        }
        return true
    }
    
    func getCardAmt() -> Int{
        return hand.count
    }
    
    var hand: [Card]
    var wincount: Int
    var losscount: Int
    var folded: Bool
    var name: String
    var cardPlayed: [Bool]
}
