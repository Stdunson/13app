//
//  CreateGame.swift
//  Thirteen
//
//  Created by Shavaughn on 12/22/24.
//

import SwiftUI

struct CreateGame: View {
    @State var numPlayers: Int = 0
    @State var message: String = "New Game"
    @State var playerList: [Player] = []
    @State var gamemode: Int = 2
    
    @State var p1name: String = ""
    @State var p2name: String = ""
    @State var p3name: String = ""
    @State var p4name: String = ""
    
    @State var p2message: String = "Enter Player 2 Name:"
    @State var p3message: String = "Player not found"
    @State var p4message: String = "Player not found"
    
    var body: some View {
        NavigationView {
            VStack {
                Text(message)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                HStack{
                    Text("Game Mode: ")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Button(action: {
                        message = "Mode Not Available"
                    }){
                        ZStack{
                            RoundedRectangle(cornerRadius: 1)
                                .frame(width: 30, height: 30)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 3) )
                                .foregroundStyle(.white)
                            Image(systemName: "person.fill")
                                .foregroundStyle(.black)
                        }
                    }
                    Button(action: {
                        message = "Local Multiplayer Game"
                        gamemode = 2
                    }){
                        ZStack{
                            RoundedRectangle(cornerRadius: 1)
                                .frame(width: 30, height: 30)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 3) )
                                .foregroundStyle(.white)
                            Image(systemName: "person.2.fill")
                                .foregroundStyle(.black)
                        }
                    }
                    Button(action: {
                        message = "Mode Not Available"
                    }){
                        ZStack{
                            RoundedRectangle(cornerRadius: 1)
                                .frame(width: 30, height: 30)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 3) )
                                .foregroundStyle(.white)
                            Image(systemName: "globe")
                                .foregroundStyle(.black)
                        }
                    }
                }
                HStack{
                    Text("Number of Players: ")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Button(action: {
                        numPlayers = 2
                        p3message = "Player not found"
                        p4message = "Player not found"
                    }){
                        ZStack{
                            Image(systemName: "2.circle")
                                .resizable()
                                .frame(maxWidth: 30, maxHeight: 30)
                                .foregroundStyle(.black)
                            
                        }
                    }
                    Button(action: {
                        numPlayers = 3
                        p3message = "Enter Player 3 Name:"
                        p4message = "Player not found"
                    }){
                        ZStack{
                            Image(systemName: "3.circle")
                                .resizable()
                                .frame(maxWidth: 30, maxHeight: 30)
                                .foregroundStyle(.black)
                            
                        }
                    }
                    Button(action: {
                        numPlayers = 4
                        p3message = "Enter Player 3 Name:"
                        p4message = "Enter Player 4 Name:"
                    }){
                        ZStack{
                            Image(systemName: "4.circle")
                                .resizable()
                                .frame(maxWidth: 30, maxHeight: 30)
                                .foregroundStyle(.black)
                            
                        }
                    }
                }
                //component which has list of name inputs based on # players
                //Do this by acc having 4 but disabling them when not needed
                TextField("Enter Player 1 Name:", text: $p1name)
                    .foregroundStyle(.black)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                TextField(p2message, text: $p2name)
                    .foregroundStyle(.black)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                TextField(p3message, text: $p3name)
                    .foregroundStyle(.black)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                TextField(p4message, text: $p4name)
                    .foregroundStyle(.black)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
                Button("Enter Players"){
                    playerList = []
                    for i in 1...numPlayers{
                        switch i{
                            case 1:
                                playerList.append(Player(pName: p1name))
                                break
                            case 2:
                                playerList.append(Player(pName: p2name))
                                break
                            case 3:
                                playerList.append(Player(pName: p3name))
                                break
                            case 4:
                                playerList.append(Player(pName: p4name))
                                break
                            default:
                                break
                        }
                    }
                }
                    .buttonStyle(.borderedProminent)
                    .tint(.gray)
                    .foregroundStyle(.black)
                    .fontWeight(.semibold)
                
                NavigationLink(destination: GamePlayLMult(players: playerList)){
                    Text("Start Game")
                        .frame(width: 300, height: 50, alignment: .center)
                        .foregroundStyle(.black)
                        .background(.gray)
                        .cornerRadius(20)
                        .fontWeight(.bold)
                        .font(.title3)
                }
            }
        }
    }
}

#Preview {
    CreateGame()
}
