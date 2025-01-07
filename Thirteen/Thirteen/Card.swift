//
//  Card.swift
//  Thirteen
//
//  Created by Shavaughn on 11/22/24.
//

import SwiftUI

//for the cards
enum Suit: CaseIterable, Comparable{
    case Spade, Club, Diamond, Heart
}

class Card: Identifiable, ObservableObject{
    init(cardVal: Int, cardSuit: Suit) {
        self.cardVal = cardVal
        self.cardSuit = cardSuit
        self.sel = false
    }
    let cardVal: Int
    let cardSuit: Suit
    let id = UUID()
    @Published var sel: Bool
    func togglesel(){
        if(sel){
            sel = false
        }else{
            sel = true
        }
    }
}

struct CardView: View{
    @State var card: Card
    @State var selected: Bool = false
    @State var cardOpacity: Double = 1
    
    var cardColor: Color{
        if(card.cardSuit == Suit.Spade || card.cardSuit == Suit.Club){
            return Color.black
        }else{
            return Color.red
        }
    }
    
    func toggleSelected(){
        if(selected){
            cardOpacity = 1
            selected = false
        }else{
            cardOpacity = 0.2
            selected = true
        }
    }
    
    var suitImage: String{
        switch card.cardSuit {
            case Suit.Spade:
                return "suit.spade.fill"
            case Suit.Club:
                return "suit.club.fill"
            case Suit.Diamond:
                return "suit.diamond.fill"
            case Suit.Heart:
                return "suit.heart.fill"
        }
    }
    
    var cardNum: String{
        if(card.cardVal <= 8 && card.cardVal != 0){
            return String(card.cardVal + 2)
        }else if(card.cardVal == 9){
            return "J"
        }else if(card.cardVal == 10){
            return "Q"
        }else if(card.cardVal == 11){
            return "K"
        }else if(card.cardVal == 12){
            return "A"
        }else if(card.cardVal == 13){
            return "2"
        }
        return "error"
    }
    
    var body: some View {
        Button(action: {
            toggleSelected()
            card.togglesel()
        }){
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 60, height: 90)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 3) )
                    .foregroundStyle(.white)
                VStack{
                    Text(cardNum)
                        .foregroundStyle(cardColor)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                    Image(systemName: suitImage)
                        .foregroundStyle(cardColor)
                        .font(.largeTitle)
                }
            }
            .opacity(cardOpacity)
        }
    }
}

#Preview {
    CardView(card: Card(cardVal: 11, cardSuit: Suit.Heart))
}
