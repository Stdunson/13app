//
//  GameOverSingle.swift
//  Thirteen
//
//  Created by Shavaughn on 1/7/25.
//

import SwiftUI

struct GameOverSingle: View {
    let players: [Player]
    let winner: Int
    var body: some View {
        NavigationView {
            VStack{
                if(winner == 0){
                    Text("You won the game!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding([.top, .leading, .trailing])
                        .multilineTextAlignment(.center)
                    if players[winner].hand.count == 0{
                        Text("You ran out of cards")
                            .font(.headline)
                            .padding(.bottom)
                    }else{
                        if(players[winner].hasAllTwos()){
                            Text("You had all of the 2s!")
                                .font(.headline)
                                .padding(.bottom)
                        }else if(players[winner].has13Straight()){
                            Text("You had 13 straight!")
                                .font(.headline)
                                .padding(.bottom)
                        }
                    
                    }
                }else{
                    Text("\(players[winner].name) has won the game")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding([.top, .leading, .trailing])
                        .multilineTextAlignment(.center)
                    if players[winner].hand.isEmpty{
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
                }
                VStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 30)
                                .frame(width: 150, height: 120)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 5) )
                                .foregroundStyle(.white)
                            VStack{
                                Text("Wins: \(players[0].getWins())")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                Text("Losses: \(players[0].getWins())")
                                    .font(.title)
                                    .fontWeight(.semibold)
                            }
                    }
                }
                    .padding()
                VStack{
                    NavigationLink(destination: GamePlaySingle(players: players)){
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
    GameOverSingle(players: [Player(pName: "Shavaughn"), Player(pName: "CPU1"), Player(pName: "CPU2"), Player(pName: "CPU3")], winner: 0)
}
