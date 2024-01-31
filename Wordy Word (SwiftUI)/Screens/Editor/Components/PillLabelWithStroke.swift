//  
//  PillLabelWithStroke.swift
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

struct PillLabelWithStroke: View {
    
    let count: Int
    let text: String
    let textColor: Color
    let backgroundColor: Color
    let borderColor: Color
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 10) {
            
            Text("\(count)")
            Text(text)
        }
        .font(Font.custom(.fonts.poppinsMedium, size: 16))
        .frame(maxHeight: .infinity)
        .padding([.leading, .trailing], 25)
        .background(
            Capsule()
                .strokeBorder(borderColor ,lineWidth: 1.0)
                .background(Capsule().fill(backgroundColor))
        )
        .foregroundStyle(textColor)
    }
}


#Preview {
    PillLabelWithStroke(count: 0, text: "Character", textColor: .text.black, backgroundColor: .background.quarternary, borderColor: .text.black)
}
