//
//  ComputerPlay.swift
//  Thirteen
//
//  Created by Shavaughn on 1/2/25.
//

import Foundation
import SwiftUI

class ComputerPlay {
    init(newGame: GameObject) {
        game = newGame
    }
    
    //function to determine what cpu will play
    func playTurn(player: Player) -> [Card]{
        var myPlay: [Card] = []
        //if starting round, find highest straight or of a kind that they can play and play on top of
        //if not figure out if a player is low. If so, go as high as possible. If not, go as low as possible. If can't play, fold.
        return myPlay
    }
    
    var game: GameObject
    
}
