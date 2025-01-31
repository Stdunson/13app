//
//  GamePlaySingle.swift
//  Thirteen
//
//  Created by Shavaughn on 1/1/25.
//

import SwiftUI
import Foundation

struct GamePlaySingle: View {
    @State var players: [Player]
    
    var numPlayers: Int{
        return players.count
    }
    
    @State var deckReady: Bool = false
    @State var currPlayerIndex: Int = 0
    @State var message: String = "Play your turn!"
    @State var playLog: String = "Play Log"
    @State var currCards: [Card] = []
    @State var game: GameObject = GameObject(players: [])
    @State var cpu: ComputerPlay = ComputerPlay(newGame: GameObject(players: []))
    @State var viewID = UUID()
    @State var gameOver: Bool = false
    @State var winner: Int = 0
    @State var showHand: Bool = false
    
    func cpuPlay(){
        playLog = ""
        while(currPlayerIndex != 0 && !game.isGameOver()){
            let play: [Card] = cpu.playTurn(player: players[currPlayerIndex])
            if play.count == 0{
                players[currPlayerIndex].fold()
                playLog += "\n\(players[currPlayerIndex].getName()) has folded."
                nextPlayer()
            }else{
                if(game.isLegalPlay(cardList: play)){
                    game.playCards(player: players[currPlayerIndex], cardList: play)
                    currCards = game.currPlay
                }
                var playString: String = ""
                for card in play{
                    var cardNum: String{
                        if(card.cardVal <= 8 && card.cardVal != 0){
                            return String(card.cardVal + 2)
                        }else if(card.cardVal == 9){
                            return "Jack"
                        }else if(card.cardVal == 10){
                            return "Queen"
                        }else if(card.cardVal == 11){
                            return "King"
                        }else if(card.cardVal == 12){
                            return "Ace"
                        }else if(card.cardVal == 13){
                            return "2"
                        }
                        return "error"
                    }
                    var cardSuitString: String{
                        if(card.cardSuit == Suit.Heart){
                            return "Hearts"
                        }else if(card.cardSuit == Suit.Diamond){
                            return "Diamonds"
                        }else if(card.cardSuit == Suit.Club){
                            return "Clubs"
                        }else if(card.cardSuit == Suit.Spade){
                            return "Spades"
                        }
                        return "error"
                    }
                    
                    playString += cardNum + " of " + cardSuitString
                    if(card.cardVal == play[play.count - 1].cardVal && play[play.count - 1].cardSuit == card.cardSuit){
                        playString += "."
                    }else{
                        playString += ", "
                    }
                }
                playLog += "\n\(players[currPlayerIndex].getName()) has played \(playString)"
                nextPlayer()
            }
        }
    }
    
    func nextPlayer(){
        if game.isRoundOver(){
            if(game.isGameOver()){
                winner = game.manageWins()
                if(winner == 0){
                    message = "Congrats! You have won the game!"
                }else{
                    message = "\(players[winner].name) has won the game"
                }
                gameOver = true
                viewID = UUID()
                return
            }
            currPlayerIndex = game.StartNewRound(lastFolder: currPlayerIndex)
            if(currPlayerIndex == 0){
                message = "\(players[currPlayerIndex].name), start the next round"
            }else{
                message = "\(players[currPlayerIndex].name) has started the round"
            }
            currCards = []
            return
        }
        if currPlayerIndex == numPlayers - 1{
            for p in 0..<numPlayers{
                if !players[p].hasFolded(){
                    currPlayerIndex = p
                    break
                }
            }
        }else{
            let currIn: Int = currPlayerIndex
            for p in currPlayerIndex + 1..<numPlayers{
                if !players[p].hasFolded(){
                    currPlayerIndex = p
                    break
                }
            }
            if(currPlayerIndex == currIn){
                for p in 0..<currPlayerIndex{
                    if !players[p].hasFolded(){
                        currPlayerIndex = p
                        break
                    }
                }
            }
        }
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
                        .padding(.horizontal)
                    //play log
                    Text(playLog)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding([.leading, .bottom, .trailing])
                    //other players' name + amt cards
                    HStack{
                        ForEach(players) { player in
                            if(!player.equals(otherPlayer: players[0])){
                                PlayerInfoCard(player: player)
                                    .id(viewID)
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
                            ForEach(players[0].hand){ card in
                                CardView(card: card)
                            }
                        }
                    }
                        .frame(height: 100)
                    HStack{
                        if currPlayerIndex == 0{
                            //play button
                            Button("Play cards"){
                                if(players[currPlayerIndex].equals(otherPlayer: players[0])){
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
                                            if(!game.isGameOver()){
                                                nextPlayer()
                                                cpuPlay()
                                                viewID = UUID()
                                            }
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
                            }
                                .buttonStyle(.borderedProminent)
                                .tint(.gray)
                                .foregroundStyle(.black)
                                .fontWeight(.semibold)
                            //fold button
                            Button("Fold"){
                                if(players[currPlayerIndex].equals(otherPlayer: players[0])){
                                    if(!players[currPlayerIndex].hasFolded() && !game.isFirstRound){
                                        players[currPlayerIndex].fold()
                                        nextPlayer()
                                        if(!game.isGameOver() && currPlayerIndex != 0){
                                            cpuPlay()
                                        }
                                        viewID = UUID()
                                    }else if(game.isFirstRound){
                                        message = "Invalid play. Try Again, \(players[currPlayerIndex].name)"
                                    }
                                }
                            }
                                .buttonStyle(.borderedProminent)
                                .tint(.gray)
                                .foregroundStyle(.black)
                                .fontWeight(.semibold)
                        }
                    }
                    .navigationDestination(isPresented: $gameOver){
                        GameOverSingle(players: players, winner: winner)
                    }
                }
            }else{
                Text("Deck loading")
            }
        }
        .onAppear(perform: {
            let gameDeck: Deck = Deck()
            game = GameObject(players: players)
            cpu = ComputerPlay(newGame: game)
            gameDeck.deal(players: players)
            currPlayerIndex = game.StartFirstRound()
            if(game.isGameOver()){
                winner = game.manageWins()
                if(winner == 0){
                    message = "Congrats! You have won the game!"
                }else{
                    message = "\(players[winner].name) has won the game"
                }
                gameOver = true
                viewID = UUID()
            }else{
                if(currPlayerIndex == 0){
                    message = "Play the first turn, \(players[currPlayerIndex].name)!"
                }else{
                    message = "\(players[currPlayerIndex].name) will play the first turn"
                    cpuPlay()
                }
            }
            deckReady = true
        })
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    GamePlaySingle(players: [Player(pName: "Shavaughn"), Player(pName: "CPU 1"), Player(pName: "CPU 2")])
}
