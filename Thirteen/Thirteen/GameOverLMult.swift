//
//  GameOverLMult.swift
//  Thirteen
//
//  Created by Shavaughn on 12/27/24.
//

import SwiftUI

struct GameOverLMult: View {
    let players: [Player]
    let winner: Int
    
    var body: some View {
        NavigationView {
            VStack{
                Text("\(players[winner].name) has won the game")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding([.top, .leading, .trailing])
                    .multilineTextAlignment(.center)
                if players[winner].hand.count == 0{
                    Text("\(players[winner].name) ran out of cards")
                        .font(.headline)
                        .padding(.bottom)
                }else{
                    if(players[winner].hasAllTwos()){
                        Text("\(players[winner].name) had all of the 2s")
                            .font(.headline)
                            .padding(.bottom)
                    }else if(players[winner].has13Straight()){
                        Text("\(players[winner].name) had 13 straight")
                            .font(.headline)
                            .padding(.bottom)
                    }
                
                }
                VStack{
                    ForEach(players) { player in
                        ZStack{
                            RoundedRectangle(cornerRadius: 30)
                                .frame(width: 120, height: 80)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 3) )
                                .foregroundStyle(.white)
                            VStack{
                                Text("\(player.getName())")
                                    .bold()
                                Text("Wins: \(player.getWins())")
                                Text("Losses: \(player.getWins())")
                            }
                        }
                    }
                }
                    .padding()
                VStack{
                    NavigationLink(destination: GamePlayLMult(players: players)){
                        Text("Play Again")
                            .frame(width: 150, height: 50, alignment: .center)
                            .foregroundStyle(.black)
                            .background(.gray)
                            .cornerRadius(20)
                            .fontWeight(.bold)
                            .font(.title3)
                    }
                    NavigationLink(destination: ContentView()){
                        Text("Quit")
                            .frame(width: 150, height: 50, alignment: .center)
                            .foregroundStyle(.black)
                            .background(.gray)
                            .cornerRadius(20)
                            .fontWeight(.bold)
                            .font(.title3)
                    }
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    GameOverLMult(players: [Player(pName: "Shavaughn"), Player(pName: "STDemon"), Player(pName: "Shadiddy"), Player(pName: "Shaglizzy")], winner: 0)
}
