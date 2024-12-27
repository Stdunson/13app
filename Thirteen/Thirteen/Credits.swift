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
                Text("- Socials: [Instagram](https://www.instagram.com/stdunson/?hl=en), [Linkedin](https://www.linkedin.com/in/shavaughn-dunson/), [Github](https://github.com/Stdunson)")                
            }
            .accentColor(.gray)
        }
    }
}

#Preview {
    Credits()
}
