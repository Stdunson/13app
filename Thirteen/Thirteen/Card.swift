//
//  Card.swift
//  Thirteen
//
//  Created by Shavaughn on 11/22/24.
//

import SwiftUI

//for the cards
enum Suit: CaseIterable{
    case Spade, Club, Diamond, Heart
}

struct Card: View{
    let cardVal: Int
    let cardSuit: Suit
    @State var played: Bool = false
    
    var cardColor: Color{
        if(cardSuit == Suit.Spade || cardSuit == Suit.Club){
            return Color.black
        }else{
            return Color.red
        }
    }
    
    var suitImage: String{
        switch cardSuit {
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
        if(cardVal <= 8 && cardVal != 0){
            return String(cardVal + 2)
        }else if(cardVal == 9){
            return "J"
        }else if(cardVal == 10){
            return "Q"
        }else if(cardVal == 11){
            return "K"
        }else if(cardVal == 12){
            return "A"
        }else if(cardVal == 12){
            return "2"
        }
        return "error"
    }
    
    var body: some View {
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
    }
}

#Preview {
    Card(cardVal: 11, cardSuit: Suit.Heart)
}
