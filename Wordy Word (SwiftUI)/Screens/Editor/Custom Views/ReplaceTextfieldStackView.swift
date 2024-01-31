//  
//  ReplaceTextfieldStackView.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 03/11/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct ReplaceTextfieldStackView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @FocusState.Binding var isFocused: whichTextfieldOrTextEditorIsFocused?
    
    @State private var temporaryInputForFindText = ""
    @State private var temporaryInputForReplaceWith = ""
    
    @State private var findKeyboardDoneOnSubmitButton = false
    @State private var replaceKeyboardDoneOnSubmitButton = false
    
    var body: some View {
        
        HStack(spacing: 10) {
            
            TextField("Find text", text: $temporaryInputForFindText)
                .focused($isFocused, equals: .find)
                .submitLabel(findKeyboardDoneOnSubmitButton ? .done : .next)
                .onSubmit { checkTextfieldOnSubmit(isFocused) }
                .replaceTextfieldStyle(currentFocusState: isFocused, focus: .find)
            
            TextField("Replace with", text: $temporaryInputForReplaceWith)
                .focused($isFocused, equals: .replace)
                .submitLabel(replaceKeyboardDoneOnSubmitButton ? .done : .next)
                .onSubmit { checkTextfieldOnSubmit(isFocused) }
                .replaceTextfieldStyle(currentFocusState: isFocused, focus: .replace)
        }
        .onChange(of: temporaryInputForFindText) { text in
            
            if text.isEmpty {
                replaceKeyboardDoneOnSubmitButton = false
            } else {
                replaceKeyboardDoneOnSubmitButton = true
            }
        }
        .onChange(of: temporaryInputForReplaceWith) { text in
            
            if text.isEmpty {
                findKeyboardDoneOnSubmitButton = false
            } else {
                findKeyboardDoneOnSubmitButton = true
            }
        }
    }
}

#Preview {
    ReplaceTextfieldStackView(isFocused: FocusState<whichTextfieldOrTextEditorIsFocused?>().projectedValue)
        .environmentObject(MockViewModel.shared.viewModel)
}

extension ReplaceTextfieldStackView {
    
    private func checkTextfieldOnSubmit(_ currentlyInFocus: whichTextfieldOrTextEditorIsFocused?) {
        
        if currentlyInFocus == .find && temporaryInputForReplaceWith.isEmpty {
            isFocused = .replace
        } else if currentlyInFocus == .replace && temporaryInputForFindText.isEmpty {
            isFocused = .find
        } else {
            isFocused = nil
            viewModel.replaceWithText = temporaryInputForReplaceWith
            viewModel.findText = temporaryInputForFindText
            viewModel.beginEditingText()
        }
    }
}
