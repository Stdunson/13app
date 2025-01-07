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
    
    //this computer trash at the game but I'll make it better later
    //function assumes game is not over and player hasn't folded
    func playTurn(player: Player) -> [Card]{
        var myPlay: [Card] = []
        
        var validPlays: [[Card]] = []
        for length in 1...player.hand.count {
            func genCombs(start: Int, current: [Card]){
                if current.count == length{
                    validPlays.append(current)
                    return
                }
                
                for i in start..<player.hand.count{
                    genCombs(start: i + 1, current: current + [player.hand[i]])
                }
            }
            genCombs(start: 0, current: [])
        }
        validPlays.removeAll{play in !game.isLegalPlay(cardList: play)}
        
        if game.currPlay.count == 0 {
            var straigtCount: Int = 0
            for play in validPlays{
                if !(play.count < 3) && !(play[1].cardVal - play[0].cardVal == 0){
                    straigtCount += 1
                }
            }
            let hasStraight: Bool = !(straigtCount == 0)
            
            if hasStraight{
                //find straight with the most cards + lowest cards
                for play in validPlays{
                    let max = play.count - 1
                    if max > 0{
                        if !(play.count < 3) && !(play[1].cardVal - play[0].cardVal == 0) && play.count > myPlay.count{
                            myPlay = play
                        }else if !(play.count < 3) && !(play[1].cardVal - play[0].cardVal == 0) && play.count == myPlay.count{
                            if play[max].cardVal < myPlay[max].cardVal{
                                myPlay = play
                            }else if play[max].cardSuit < myPlay[max].cardSuit && play[max].cardVal == myPlay[max].cardVal{
                                myPlay = play
                            }
                        }
                    }
                }
            }else{
                //find play with the most cards + lowest cards
                for play in validPlays{
                    let max = play.count - 1
                    if play.count > myPlay.count{
                        myPlay = play
                    }else if play.count == myPlay.count{
                        if play[max].cardVal < myPlay[max].cardVal{
                            myPlay = play
                        }else if play[max].cardSuit < myPlay[max].cardSuit && play[max].cardVal == myPlay[max].cardVal{
                            myPlay = play
                        }
                    }
                }
            }

        }else{
            if validPlays.isEmpty{
                return []
            }
            
            let max = game.currPlay.count - 1
            
            //dw bout this filth just know it's a sorting alg which sorts each valid play
            if max != 0{
                for h in 0..<validPlays.count{
                    for i in 0..<validPlays[h].count - 1{
                        for j in 0..<validPlays[h].count - 1 - i{
                            if(validPlays[h][j + 1].cardVal < validPlays[h][j].cardVal){
                                let temp: Card = validPlays[h][j]
                                validPlays[h][j] = validPlays[h][j + 1]
                                validPlays[h][j + 1] = temp
                            }else if(validPlays[h][j + 1].cardVal == validPlays[h][j].cardVal && validPlays[h][j + 1].cardSuit < validPlays[h][j].cardSuit){
                                let temp: Card = validPlays[h][j]
                                validPlays[h][j] = validPlays[h][j + 1]
                                validPlays[h][j + 1] = temp
                            }
                        }
                    }
                }
            }
            
            var playerLow: Bool = false
            for player in game.players{
                if(player.hand.count <= 4){
                    playerLow = true
                    break
                }
            }
            if(playerLow){
                myPlay = validPlays[0]
                for play in validPlays{
                    if play[max].cardVal > myPlay[max].cardVal{
                        myPlay = play
                    }else if play[max].cardSuit > myPlay[max].cardSuit && play[max].cardVal == myPlay[max].cardVal{
                        myPlay = play
                    }
                }
            }else{
                myPlay = validPlays[0]
                for play in validPlays{
                    if play[max].cardVal < myPlay[max].cardVal{
                        myPlay = play
                    }else if play[max].cardSuit < myPlay[max].cardSuit && play[max].cardVal == myPlay[max].cardVal{
                        myPlay = play
                    }
                }
            }
        }
        return myPlay
    }
    
    var game: GameObject
    
}
