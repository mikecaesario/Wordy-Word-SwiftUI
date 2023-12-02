//  
//  DefaultPillButtonView.swift
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

struct DefaultPillButtonView: View {
    
    let imageName: String
    let withLabel: String
    let labelColor: Color
    let backgroundColor: Color
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 10) {
            
            Image(systemName: imageName)
            Text(withLabel)
        }
        .font(Font.custom(.fonts.poppinsMedium, size: 16))
        .foregroundStyle(labelColor)
        .frame(maxHeight: .infinity)
        .padding([.leading, .trailing], 25)
        .frame(width: 130)
        .background(
            Capsule()
                .foregroundStyle(backgroundColor)
        )
        .font(.system(size: 16))
    }
}


#Preview {
    DefaultPillButtonView(imageName: "doc.on.clipboard", withLabel: "Paste", labelColor: .text.black, backgroundColor: .button.paste)
}
