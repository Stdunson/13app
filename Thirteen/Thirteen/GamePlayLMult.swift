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
    @State var viewID = UUID()
    @State var gameOver: Bool = false
    @State var winner: Int = 0
    @State var showHand: Bool = false
    
    func nextPlayer(){
        if game.isRoundOver(){
            if(game.isGameOver()){
                winner = game.manageWins()
                message = "Congrats! \(players[winner].name) has won the game!"
                gameOver = true
                return
            }
            currPlayerIndex = game.StartNewRound(lastFolder: currPlayerIndex)
            message = "\(players[currPlayerIndex].name), start the next round"
            currCards = []
            return
        }
        if currPlayerIndex == numPlayers - 1{
            for p in 0..<numPlayers{
                if !players[p].hasFolded(){
                    currPlayerIndex = p
                    message = "Play your turn, \(players[currPlayerIndex].name)"
                    break
                }
            }
        }else{
            let currIn: Int = currPlayerIndex
            for p in currPlayerIndex + 1..<numPlayers{
                if !players[p].hasFolded(){
                    currPlayerIndex = p
                    message = "Play your turn, \(players[currPlayerIndex].name)"
                    break
                }
            }
            if(currPlayerIndex == currIn){
                for p in 0..<currPlayerIndex{
                    if !players[p].hasFolded(){
                        currPlayerIndex = p
                        message = "Play your turn, \(players[currPlayerIndex].name)"
                        break
                    }
                }
            }
        }
    }
    
    func orderPlayers() -> [Player]{
        var newOther: [Player] = []
        for i in currPlayerIndex + 1..<numPlayers{
            newOther.append(players[i])
        }
        if(currPlayerIndex == 0){
            return newOther
        }
        for i in 0..<currPlayerIndex{
            newOther.append(players[i])
        }
        
        return newOther
    }
    
    var body: some View {
        NavigationStack {
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
                        let otherPlayerList: [Player] = orderPlayers()
                        ForEach(otherPlayerList) { player in
                            PlayerInfoCard(player: player)
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
                    if(showHand){
                        ScrollView(.horizontal){
                            HStack{
                                ForEach(players[currPlayerIndex].hand){ card in
                                    CardView(card: card)
                                }
                            }
                        }
                            .frame(height: 100)
                    }
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
                                    showHand = false
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
                            if(!players[currPlayerIndex].hasFolded() && !game.isFirstRound){
                                players[currPlayerIndex].fold()
                                showHand = false
                                nextPlayer()
                                viewID = UUID()
                            }else if(game.isFirstRound){
                                message = "Invalid play. Try Again, \(players[currPlayerIndex].name)"
                            }
                        }
                            .buttonStyle(.borderedProminent)
                            .tint(.gray)
                            .foregroundStyle(.black)
                            .fontWeight(.semibold)
                        //button to show hand
                        Button("Show Hand"){
                            showHand = true
                            viewID = UUID()
                        }
                            .buttonStyle(.borderedProminent)
                            .tint(.gray)
                            .foregroundStyle(.black)
                            .fontWeight(.semibold)
                    }
                    .navigationDestination(isPresented: $gameOver){
                        GameOverLMult(players: players, winner: winner)
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
    GamePlayLMult(players: [Player(pName: "Shavaughn"), Player(pName: "Himothy")])
}
