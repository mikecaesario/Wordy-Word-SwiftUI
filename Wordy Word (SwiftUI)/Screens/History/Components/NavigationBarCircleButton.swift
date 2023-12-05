//  
//  NavigationBarCircleButton.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 05/12/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct NavigationBarCircleButton: View {
    
    let symbolName: String
    
    var body: some View {
        
        ZStack {
            
            Circle()
                .fill(Color.background.thirtiary)
            
            Image(systemName: symbolName)
                .font(.system(size: 20, weight: .light))
                .imageScale(.small)
                .foregroundStyle(Color.text.white)
                .padding()
        }
    }
}

#Preview {
    NavigationBarCircleButton(symbolName: "chevron.left")
}
