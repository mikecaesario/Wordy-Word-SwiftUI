//  
//  NavigationBarCircleButtonView.swift
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

struct NavigationBarCircleButtonView: View {
    
    let symbolName: String
    let backgroundColor: Color
    let onButtonPress: () -> ()
    
    var body: some View {
        
        Button {
            onButtonPress()
        } label: {
            
            ZStack(alignment: .center) {
                
                Circle()
                    .aspectRatio(1, contentMode: .fill)
                    .foregroundStyle(backgroundColor)
                
                Image(systemName: symbolName)
                    .font(Font.system(size: 20, weight: .light))
                    .imageScale(.small)
                    .foregroundStyle(Color.text.white)
            }
        }
    }
}

#Preview {
    NavigationBarCircleButtonView(symbolName: "slider.horizontal.3", backgroundColor: .background.thirtiary) {
        
    }
}
