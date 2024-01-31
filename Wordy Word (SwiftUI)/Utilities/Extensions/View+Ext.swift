//  
//  View+Ext.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 25/10/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import Foundation
import SwiftUI

extension View {
    
    func getViewSize(_ size: Binding<CGSize>) -> some View {
        modifier(GetViewSizeViewModifier(size: size))
    }
    
    func disableTextEditorBackground() -> some View {
        
        if #available(iOS 16.0, *) {
            return scrollContentBackground(.hidden)
        } else {
            return onAppear {
                UITextView.appearance().backgroundColor = .clear
            }
        }
    }
    
    func replaceTextfieldStyle(currentFocusState: whichTextfieldOrTextEditorIsFocused?, focus: whichTextfieldOrTextEditorIsFocused) -> some View {
        modifier(ReplaceTextfieldViewModifier(currentlyInFocus: currentFocusState, focus: focus))
    }
    
    func historyHeaderStyle() -> some View {
        modifier(HistoryHeaderViewModifier())
    }
    
    func toastView(_ show: Bool, withType: ToastType) -> some View {
        modifier(ToastViewModifier(showToast: show, type: withType))
    }
}
