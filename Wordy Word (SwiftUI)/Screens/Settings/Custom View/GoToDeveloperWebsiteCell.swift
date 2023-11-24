//  
//  GoToDeveloperWebsiteCell.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 15/11/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct GoToDeveloperWebsiteCell: View {
        
    @State private var viewSize: CGSize = .zero
    
    private let label = "Developer"
    private let devName = "Michael Caesario"
    
    var body: some View {
        
        ZStack {
            
            HStack {
                
                Text(label)
                    .font(.custom(.fonts.poppinsMedium, size: 20))
                
                Spacer()
                
                Text(devName)
                    .font(.custom(.fonts.poppinsSemiBold, size: 20))

            }
            .foregroundStyle(Color.text.white)
            .lineLimit(1)
            .minimumScaleFactor(0.8)
            .padding(18)

        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.background.thirtiary)
        )
    }
}

#Preview {
    GoToDeveloperWebsiteCell()
}
