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
    
    @FocusState private var focusedTextfield: ReplaceTextfieldEnum?
    
    var body: some View {
        
        HStack(spacing: 10) {
            
            TextField("Find text", text: $viewModel.findText)
                .focused($focusedTextfield, equals: .find)
                .submitLabel(prepareSubmitLabel(focusedTextfield) ? .done : .next)
                .onSubmit { checkTextfieldOnSubmit(focusedTextfield) }
                .replaceTextfieldStyle(currentFocusState: focusedTextfield, focus: .find)

            
            TextField("Replace with", text: $viewModel.replaceWithText)
                .focused($focusedTextfield, equals: .replace)
                .submitLabel(prepareSubmitLabel(focusedTextfield) ? .done : .next)
                .onSubmit { checkTextfieldOnSubmit(focusedTextfield) }
                .replaceTextfieldStyle(currentFocusState: focusedTextfield, focus: .replace)
        }
    }
}

#Preview {
    ReplaceTextfieldStackView()
        .environmentObject(MockViewModel.shared.viewModel)
}

extension ReplaceTextfieldStackView {
    
    private func checkTextfieldOnSubmit(_ currentlyInFocus: ReplaceTextfieldEnum?) {
        
        if currentlyInFocus == .find && viewModel.replaceWithText.isEmpty {
            focusedTextfield = .replace
        } else if currentlyInFocus == .replace && viewModel.findText.isEmpty {
            focusedTextfield = .find
        } else {
            focusedTextfield = nil
        }
    }
    
    private func prepareSubmitLabel(_ currentlyInFocus: ReplaceTextfieldEnum?) -> Bool {
        
        if currentlyInFocus == .find && viewModel.replaceWithText.isEmpty {
            return false
        } else if currentlyInFocus == .replace && viewModel.findText.isEmpty {
            return false
        }
        
        return true
    }
}
public enum ReplaceTextfieldEnum: Hashable {
    case find, replace
}

struct ReplaceTextfieldViewModifier: ViewModifier {
    
    var currentlyInFocus: ReplaceTextfieldEnum?
    let focus: ReplaceTextfieldEnum
    
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
