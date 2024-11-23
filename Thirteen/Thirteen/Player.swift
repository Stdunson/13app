//
//  Player.swift
//  Thirteen
//
//  Created by Shavaughn on 11/23/24.
//

import Foundation
import SwiftUI

class Player{
    //public
    init(){
        self.hasFold = false
        self.isTurn = false
        self.hand = []
    }
    func setHand(newHand: [Card]){
        hand = newHand
    }
    func play(playCard: Card)->Card{
        let cardIndex: Int = hand.firstIndex(of: playCard)!
        hand.remove(at: cardIndex)
        return playCard
    }
    //private
    var hasFold: Bool
    var isTurn: Bool
    var hand: [Card]
}
