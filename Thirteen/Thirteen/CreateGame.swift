//
//  CreateGame.swift
//  Thirteen
//
//  Created by Shavaughn on 12/22/24.
//

import SwiftUI

struct CreateGame: View {
    @State var numPlayers: Int = 2
    @State var message: String = "New Game"
    @State var players: [Player] = []
    @State var gamemode: Int = 2
    
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
                    }){
                        ZStack{
                            Image(systemName: "4.circle")
                                .resizable()
                                .frame(maxWidth: 30, maxHeight: 30)
                                .foregroundStyle(.black)
                            
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CreateGame()
}
