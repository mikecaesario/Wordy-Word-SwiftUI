//  
//  PillButtonWithStroke.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 02/12/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct PillButtonWithStroke: View {
    
    let character: String
    let isCurrentlySelected: Bool
    let onButtonPress: () -> ()
    
    var body: some View {
        
        Button {
            
            onButtonPress()
        } label: {
            
            Text(character)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(isCurrentlySelected ? Color.text.black : Color.text.grey)
        }
        .padding()
        .frame(width: 90, height: 55)
        .background(
            Capsule()
                .foregroundStyle(isCurrentlySelected ?  Color.background.quarternary : .clear)
                .background(
                    Capsule()
                        .stroke(isCurrentlySelected ? Color.background.quarternary : Color.button.strokeLight, lineWidth: 1.0)
                )
        )
    }
}


#Preview {
    PillButtonWithStroke(character: "&", isCurrentlySelected: false) {
        
    }
}
