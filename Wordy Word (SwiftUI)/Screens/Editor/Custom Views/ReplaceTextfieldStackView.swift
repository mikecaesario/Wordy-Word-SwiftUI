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
    
    var body: some View {
        
        HStack(spacing: 10) {
            
            TextField("Find text", text: $viewModel.findText)
                .focused($isFocused, equals: .find)
                .submitLabel(prepareSubmitLabel(isFocused) ? .done : .next)
                .onSubmit { checkTextfieldOnSubmit(isFocused) }
                .replaceTextfieldStyle(currentFocusState: isFocused, focus: .find)


            
            TextField("Replace with", text: $viewModel.replaceWithText)
                .focused($isFocused, equals: .replace)
                .submitLabel(prepareSubmitLabel(isFocused) ? .done : .next)
                .onSubmit { checkTextfieldOnSubmit(isFocused) }
                .replaceTextfieldStyle(currentFocusState: isFocused, focus: .replace)
        }
    }
}

#Preview {
    ReplaceTextfieldStackView(isFocused: FocusState<whichTextfieldOrTextEditorIsFocused?>().projectedValue)
        .environmentObject(MockViewModel.shared.viewModel)
}

extension ReplaceTextfieldStackView {
    
    private func checkTextfieldOnSubmit(_ currentlyInFocus: whichTextfieldOrTextEditorIsFocused?) {
        
        if currentlyInFocus == .find && viewModel.replaceWithText.isEmpty {
            isFocused = .replace
        } else if currentlyInFocus == .replace && viewModel.findText.isEmpty {
            isFocused = .find
        } else {
            isFocused = nil
            viewModel.beginEditingText()
        }
    }
    
    private func prepareSubmitLabel(_ currentlyInFocus: whichTextfieldOrTextEditorIsFocused?) -> Bool {
        
        if currentlyInFocus == .find && viewModel.replaceWithText.isEmpty {
            return false
        } else if currentlyInFocus == .replace && viewModel.findText.isEmpty {
            return false
        }
        
        return true
    }
}

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
