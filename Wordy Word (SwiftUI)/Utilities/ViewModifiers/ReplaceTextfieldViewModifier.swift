//  
//  ReplaceTextfieldViewModifier.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 28/11/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct ReplaceTextfieldViewModifier: ViewModifier {
    
    var currentlyInFocus: whichTextfieldOrTextEditorIsFocused?
    let focus: whichTextfieldOrTextEditorIsFocused
    
    func body(content: Content) -> some View {
        
        content
            .tint(.accent)
            .foregroundStyle(currentlyInFocus == focus ? Color.text.black : Color.text.white)
            .padding()
            .background(
                Capsule()
                    .foregroundStyle(currentlyInFocus == focus ? Color.background.quarternary : Color.background.secondary)
            )
            .animation(.default, value: currentlyInFocus)
    }
}
