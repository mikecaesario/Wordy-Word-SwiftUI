//  
//  ToastViewModifier.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 10/12/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct ToastViewModifier: ViewModifier {
    
    var showToast: Bool
    let type: ToastType
    
    func body(content: Content) -> some View {
        
        content
            .overlay {
                
                ZStack {
                    
                    if showToast {
                        
                        ToastView(type: type)
                            .transition(.move(edge: .bottom))
                    }
                }
                .animation(.linear(duration: 1.0), value: showToast)
            }
    }
}
