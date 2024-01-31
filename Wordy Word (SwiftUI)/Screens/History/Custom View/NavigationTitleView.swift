//  
//  NavigationTitleView.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 07/11/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct NavigationTitleView: View {
    
    let title: String
    
    var body: some View {
        
        HStack {
            
            Text(title)
                .font(.custom(.fonts.poppinsSemiBold, size: 30))
                .foregroundStyle(Color.text.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 18)
        }
        .frame(height: 100)
        .background(
            LinearGradient(stops: [Gradient.Stop(color: .background.primary, location: 0.6), Gradient.Stop(color: .clear, location: 1.0)], startPoint: .top, endPoint: .bottom)
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    NavigationTitleView(title: "History")
}
