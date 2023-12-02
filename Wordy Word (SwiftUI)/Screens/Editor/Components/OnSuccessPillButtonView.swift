//  
//  OnSuccessPillButtonView.swift
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

struct OnSuccessPillButtonView: View {
    
    let imageName: String
    let withLabel: String
    let labelColor: Color
    let backgroundColor: Color
    let strokeColor: Color
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 10) {
            
            Image(systemName: imageName)
            Text(withLabel)
        }
        .font(Font.custom(.fonts.poppinsMedium, size: 16))
        .foregroundStyle(labelColor)
        .frame(maxHeight: .infinity)
        .frame(width: 130)
        .background(
            Capsule()
                .strokeBorder(strokeColor ,lineWidth: 1.0)
                .background(Capsule().fill(backgroundColor))
        )
        .font(.system(size: 16))
    }
}

#Preview {
    OnSuccessPillButtonView(imageName: "checkmark", withLabel: "Pasted", labelColor: .text.black, backgroundColor: .background.quarternary, strokeColor: .text.black)
}
