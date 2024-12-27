//
//  GamePlay.swift
//  Thirteen
//
//  Created by Shavaughn on 12/22/24.
//

import SwiftUI

struct GamePlayLMult: View {
    @State var players: [Player]
    
    var numPlayers: Int{
        return players.count
    }
    
    @State var deckReady: Bool = false
    @State var currPlayerIndex: Int = 0
    @State var message: String = "Play your turn!"
    @State var currCards: [Card] = []
    @State var game: GameObject = GameObject(players: [])
    @State var viewID = UUID()  // change this to foce the view to update, workaround
    
    func nextPlayer(){
        if game.isRoundOver(){
            if(game.isGameOver()){
                let winner: Int = game.manageWins()
                message = "Congrats! \(players[winner].name) has won the game!"
                return
            }
            currPlayerIndex = game.StartNewRound(lastFolder: currPlayerIndex)
            message = "\(players[currPlayerIndex].name), start the next round"
            currCards = []
            return
        }
        if currPlayerIndex == numPlayers - 1{
            if !players[0].hasFolded(){
                currPlayerIndex = 0
                message = "Play your turn, \(players[currPlayerIndex].name)"
            }
        }else{
            if !players[currPlayerIndex + 1].hasFolded(){
                currPlayerIndex += 1
                message = "Play your turn, \(players[currPlayerIndex].name)"
            }
        }
    }
    
    var body: some View {
        NavigationView {
            if(deckReady){
                VStack{
                    //tab wit exit n allat
                    NavigationLink(destination: ContentView()){
                        ZStack{
                            Text("Quit Game")
                                .foregroundStyle(.gray)
                        }
                    }
                    //prompt
                    Text(message)
                        .font(.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding([.leading, .bottom, .trailing])
                    //other players' name + amt cards
                    HStack{
                        ForEach(players) { player in
                            if(!player.equals(otherPlayer: players[currPlayerIndex])){
                                ZStack{
                                    RoundedRectangle(cornerRadius: 30)
                                        .frame(width: 100, height: 100)
                                        .overlay(RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.black, lineWidth: 3) )
                                        .foregroundStyle(.gray)
                                        .background(.gray)
                                    VStack{
                                        Text("\(player.getName())")
                                            .fontWeight(.semibold)
                                            .frame(width: 100)
                                            .multilineTextAlignment(.center)
                                        Text("\(player.getCardAmt()) cards")
                                        Text("\(player.getWins()) wins")
                                    }
                                }
                            }
                        }
                    }
                    //current play
                    Text("Current Play:")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    LazyVGrid(
                        columns: Array(repeating: GridItem(.flexible(), spacing: 10, alignment: .center), count: 5),
                        spacing: 10
                    ){
                        ForEach(currCards) { card in
                            CardView(card: card)
                        }
                    }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .padding(.bottom, 45)
                    //hand
                    Text("Your Hand:")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(players[currPlayerIndex].hand){ card in
                                CardView(card: card)
                            }
                        }
                    }
                        .frame(height: 100)
                    HStack{
                        //play button
                        Button("Play cards"){
                            var selectedCards: [Card] = []
                            for card in players[currPlayerIndex].hand {
                                if card.sel {
                                    selectedCards.append(card)
                                }
                            }
                            if selectedCards.count > 0 {
                                if game.isLegalPlay(cardList: selectedCards) {
                                    game.playCards(player: players[currPlayerIndex], cardList: selectedCards)
                                    currCards = game.currPlay
                                    nextPlayer()
                                } else {
                                    message = "Invalid play. Try Again, \(players[currPlayerIndex].name)"
                                    selectedCards = []
                                }
                            } else {
                                message = "Invalid play. Try Again, \(players[currPlayerIndex].name)"
                                selectedCards = []
                            }
                            viewID = UUID()
                        }
                            .buttonStyle(.borderedProminent)
                            .tint(.gray)
                            .foregroundStyle(.black)
                            .fontWeight(.semibold)
                        //fold button
                        Button("Fold"){
                            if(!players[currPlayerIndex].hasFolded()){
                                players[currPlayerIndex].fold()
                                nextPlayer()
                                viewID = UUID()
                            }
                        }
                            .buttonStyle(.borderedProminent)
                            .tint(.gray)
                            .foregroundStyle(.black)
                            .fontWeight(.semibold)
                    }
                    
                }
            }else{
                Text("Deck loading")
            }
        }
        .onAppear(perform: {
            let gameDeck: Deck = Deck()
            game = GameObject(players: players)
            gameDeck.deal(players: players)
            currPlayerIndex = game.StartFirstRound()
            message = "Play the first turn, \(players[currPlayerIndex].name)!"
            deckReady = true
        })
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    GamePlayLMult(players: [Player(pName: "Shavaughn"), Player(pName: "STDemon")])
}
