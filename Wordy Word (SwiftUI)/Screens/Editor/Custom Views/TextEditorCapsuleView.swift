//  
//  TextEditorCapsuleView.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 26/10/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct TextEditorCapsuleView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @FocusState private var isTextEditorIsFocused: Bool
    
    private let placeholderText = "Enter or paste your text here"
    
    @FocusState.Binding var isFocused: whichTextfieldOrTextEditorIsFocused?
    
    var body: some View {
        
        ZStack {

            textEditor

            buttonAndLabelScrollView
                .frame(height: 60)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, 16)
            
        }
        .environmentObject(viewModel)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.quarternary)
        .cornerRadius(50)
    }
}

#Preview {
    
    TextEditorCapsuleView(isFocused: FocusState<whichTextfieldOrTextEditorIsFocused?>().projectedValue)
        .environmentObject(MockViewModel.shared.viewModel)
       
}

extension TextEditorCapsuleView {
    
    private var textEditor: some View {
        
        ScrollView(.vertical, showsIndicators: true) {
            
            TextField(placeholderText, text: $viewModel.editingText, axis: .vertical)
                .padding([.top, .horizontal], 25)
                .padding(.bottom, 85)
                .font(.system(size: 23, weight: .medium))
                .foregroundStyle(Color.text.black)
                .tint(Color.text.black)
                .focused($isFocused, equals: .editor)
                .submitLabel(.done)
                .environment(\.colorScheme, .light)
                .onChange(of: viewModel.editingText) { text in
                    
                    if text.last == "\n" {
                        
                        isFocused = nil
                        
                        let endIndex = viewModel.editingText.index(before: viewModel.editingText.endIndex)
                        
                        viewModel.editingText.remove(at: endIndex)
                        
                        viewModel.beginEditingText()
                    }
                }
        }
        .onTapGesture {
            isFocused = .editor
        }
    }
    
    private var buttonAndLabelScrollView: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(spacing: 3) {
                
                PillButtonImageWithText(defaultSymbol: "doc.on.clipboard",
                                        defaultLabel: "Paste",
                                        labelColor: .text.white,
                                        backgroundColor: .button.paste,
                                        
                                        onSuccessSymbol: "checkmark",
                                        onSuccessLabel: "Pasted",
                                        onSuccessLabelColor: .text.black,
                                        onSuccessBackgroundColor: .background.quarternary,
                                        strokeColor: .text.black, type: .paste) 
                
                PillLabelWithStroke(count: viewModel.editingTextCharacterCount, text: viewModel.editingTextCharacterCount > 1 ? "Characters" : "Character", textColor: .text.black, backgroundColor: .background.quarternary, borderColor: .text.black)
                
                PillLabelWithStroke(count: viewModel.editingTextWordCount, text: viewModel.editingTextWordCount > 1 ? "Words" : "Word", textColor: .text.black, backgroundColor: .background.quarternary, borderColor: .text.black)
                
                PillLabelWithStroke(count: viewModel.editingTextSentenceCount, text: viewModel.editingTextSentenceCount > 1 ? "Sentences" : "Sentence", textColor: .text.black, backgroundColor: .background.quarternary, borderColor: .text.black)
                
                PillLabelWithStroke(count: viewModel.editingTextParagraphCount, text: viewModel.editingTextParagraphCount > 1 ? "Paragraphs" : "Paragraph", textColor: .text.black, backgroundColor: .background.quarternary, borderColor: .text.black)
            }
            .padding([.leading, .trailing], 16)
        }
    }
}

