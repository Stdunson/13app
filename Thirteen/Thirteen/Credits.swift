//
//  Credits.swift
//  Thirteen
//
//  Created by Shavaughn on 12/22/24.
//

import SwiftUI

struct Credits: View {
    var body: some View {
        NavigationView {
            VStack{
                Text("Shavaughn Dunson")
                    .font(.largeTitle)
                    .bold()
                Text("- All Game Logic, Models, and UI")
            }
        }
    }
}

#Preview {
    Credits()
}
