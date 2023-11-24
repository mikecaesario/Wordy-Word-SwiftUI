//  
//  CircularTabBarButton.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 26/10/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct CircularTabBarButton: View {
    
    @State private var screenSize: CGSize = .zero
    
    let imageName: String
    let backgroundColor: Color
    let paddingAlignment: Edge.Set
    let buttonPress: () -> ()
    
    var body: some View {
        
        Button {
            buttonPress()
        } label: {
            
            ZStack(alignment: .center) {
                
                Image(systemName: imageName)
                    .imageScale(.medium)
                    .font(.system(size: 26, weight: .light))
                    .foregroundStyle(.white)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Circle()
                    .aspectRatio(1, contentMode: .fill)
                    .foregroundStyle(backgroundColor)
            )
        }
    }
}

#Preview {
    
    CircularTabBarButton(imageName: "book", backgroundColor: .button.paste, paddingAlignment: .leading) {
        
    }
}
