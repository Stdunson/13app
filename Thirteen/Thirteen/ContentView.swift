//
//  ContentView.swift
//  Thirteen
//
//  Created by Shavaughn on 11/22/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack {
                Text("Thirteen")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                NavigationLink(destination: CreateGame()){
                    Text("Play Game")
                        .frame(width: 300, height: 50, alignment: .center)
                        .foregroundStyle(.black)
                        .background(.gray)
                        .cornerRadius(20)
                        .fontWeight(.bold)
                        .font(.title3)
                }
                NavigationLink(destination: HowToPlay()){
                    Text("How To Play Thirteen")
                        .frame(width: 300, height: 50, alignment: .center)
                        .foregroundStyle(.black)
                        .background(.gray)
                        .cornerRadius(20)
                        .fontWeight(.bold)
                        .font(.title3)
                }
                //add back when adding music, etc
                /*
                NavigationLink(destination: Settings()){
                    Text("Settings")
                        .frame(width: 300, height: 50, alignment: .center)
                        .foregroundStyle(.black)
                        .background(.gray)
                        .cornerRadius(20)
                        .fontWeight(.bold)
                        .font(.title3)
                }
                */
                NavigationLink(destination: Credits()){
                    Text("Credits")
                        .frame(width: 300, height: 50, alignment: .center)
                        .foregroundStyle(.black)
                        .background(.gray)
                        .cornerRadius(20)
                        .fontWeight(.bold)
                        .font(.title3)
                }
                
            }
        }
        .padding()
        .accentColor(.black)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ContentView()
}
