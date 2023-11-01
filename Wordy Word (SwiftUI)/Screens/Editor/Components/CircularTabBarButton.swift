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
            
            ZStack {
                
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenSize.width * 0.8, height: screenSize.width * 0.8)
                    .imageScale(.medium)
                    .font(.system(size: 26, weight: .light))
                    .foregroundStyle(.white)
            }
            .padding(20)
            .background(Circle().foregroundStyle(backgroundColor))
            .padding(paddingAlignment, 5)
            .getViewSize($screenSize)
        }
    }
}

#Preview {
    
    CircularTabBarButton(imageName: "book", backgroundColor: .button.secondary, paddingAlignment: .leading) {
        
    }
    .previewLayout(.sizeThatFits)
}
