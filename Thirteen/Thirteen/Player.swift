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
    func playCards(playCards: [Card])->[Card]{
        var play: [Card] = []
        for card in playCards{
            let cardIndex: Int = hand.firstIndex(of: card)!
            play.append(playCards[cardIndex])
            hand.remove(at: cardIndex)
        }
        return play
    }
    //private
    var hasFold: Bool
    var isTurn: Bool
    var hand: [Card]
}
