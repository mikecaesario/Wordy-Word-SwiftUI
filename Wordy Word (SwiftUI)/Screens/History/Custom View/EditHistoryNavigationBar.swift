//  
//  EditHistoryNavigationBar.swift
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

struct EditHistoryNavigationBar: View {
    
    let symbolName: String
    let onButtonPress: () -> ()
    
    @State private var viewSize: CGSize = .zero
    
    var body: some View {
        
        ZStack {
            
            Button {
                onButtonPress()
            } label: {
                NavigationBarCircleButton(symbolName: symbolName)
            }
            .frame(maxWidth: viewSize.height * 0.55, maxHeight: viewSize.height * 0.55)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 18)
        }
        .frame(height: 100)
        .getViewSize($viewSize)
        .background(
            LinearGradient(stops: [Gradient.Stop(color: .background.primary, location: 0.6), Gradient.Stop(color: .clear, location: 1.0) ], startPoint: .top, endPoint: .bottom)
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}


#Preview {
    EditHistoryNavigationBar(symbolName: "chevron.left") {
        
    }
}
