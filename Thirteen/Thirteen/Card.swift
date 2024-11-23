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
var Val: [String] = ["3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A", "2"]

struct Card: View {
    let cardNum: String
    let cardSuit: Suit
    
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
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 50, height: 80)
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
    Card(cardNum: Val[10], cardSuit: Suit.Heart)
}
