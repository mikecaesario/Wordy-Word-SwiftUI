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
    @State private var textEditorValue: String = ""
    
    private let placeholderText = "Enter or paste your text here"
    
    @FocusState.Binding var isFocused: whichTextfieldOrTextEditorIsFocused?
    
    var body: some View {
        
        ZStack {
           
            TextEditor(text: $viewModel.editingText)
                .disableTextEditorBackground()
                .padding([.top, .horizontal], 20)
                .padding(.bottom, 85)
                .font(.system(size: 23, weight: .medium))
                .tint(Color.text.black)
                .foregroundStyle(viewModel.editingText == placeholderText ? Color.text.placeholder : Color.text.editor)
                .focused($isFocused, equals: .editor)
                .onTapGesture {
                    
                    if viewModel.editingText == placeholderText {
                        
                        viewModel.editingText = ""
                    }
                }
                .submitLabel(.done)
                .onSubmit { 
                    
                    isFocused = nil
                    viewModel.beginEditingText()
                }
                .onAppear { viewModel.editingText = placeholderText }
                

            buttonAndLabelScrollView
                .frame(height: 60)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, 16)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.quarternary)
        .cornerRadius(50)
        .onChange(of: isFocused) { value in
            
            if value == nil && viewModel.editingText == "" {
                viewModel.editingText = placeholderText
            }
        }
    }
}

#Preview {
    
    TextEditorCapsuleView(isFocused: FocusState<whichTextfieldOrTextEditorIsFocused?>().projectedValue)
        .environmentObject(MockViewModel.shared.viewModel)
       
}

extension TextEditorCapsuleView {
    
    var buttonAndLabelScrollView: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(spacing: 3) {
                
                PillButtonImageWithText(imageName: "doc.on.clipboard", withLabel: "Paste", labelColor: .text.white, backgroundColor: .button.paste, strokeColor: nil) {
                    viewModel.copyToClipboard()
                }
                
                PillLabelWithStroke(count: viewModel.editingTextCharacterCount, text: viewModel.editingTextCharacterCount > 1 ? "Characters" : "Character", textColor: .text.black, backgroundColor: .background.quarternary, borderColor: .text.black)
                
                PillLabelWithStroke(count: viewModel.editingTextWordCount, text: viewModel.editingTextWordCount > 1 ? "Words" : "Word", textColor: .text.black, backgroundColor: .background.quarternary, borderColor: .text.black)
                
                PillLabelWithStroke(count: viewModel.editingTextSentenceCount, text: viewModel.editingTextSentenceCount > 1 ? "Sentences" : "Sentence", textColor: .text.black, backgroundColor: .background.quarternary, borderColor: .text.black)
                
                PillLabelWithStroke(count: viewModel.editingTextParagraphCount, text: viewModel.editingTextParagraphCount > 1 ? "Paragraphs" : "Paragraph", textColor: .text.black, backgroundColor: .background.quarternary, borderColor: .text.black)
            }
            .padding([.leading, .trailing], 16)
        }
    }
}

struct PillButtonImageWithText: View {
    
    let imageName: String
    let withLabel: String
    let labelColor: Color
    let backgroundColor: Color
    let strokeColor: Color?
    let onButtonPress: () -> ()
    
    var body: some View {
        
        Button {
            onButtonPress()
            
        } label: {
            
            HStack(alignment: .center, spacing: 10) {
                
                Image(systemName: imageName)
                Text(withLabel)
            }
            .font(Font.custom(.fonts.poppinsMedium, size: 16))
            .foregroundStyle(labelColor)
            .frame(maxHeight: .infinity)
            .padding([.leading, .trailing], 25)
            .background(
                Capsule()
                    .foregroundStyle(backgroundColor)
//                    .background(Capsule().fill(backgroundColor))
            )
            .font(.system(size: 16))
        }
    }
}

struct PillLabelWithStroke: View {
    
    let count: Int
    let text: String
    let textColor: Color
    let backgroundColor: Color
    let borderColor: Color
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 10) {
            
            Text("\(count)")
            Text(text)
        }
        .font(Font.custom(.fonts.poppinsMedium, size: 16))
        .frame(maxHeight: .infinity)
        .padding([.leading, .trailing], 25)
        .background(
            Capsule()
                .strokeBorder(borderColor ,lineWidth: 1.0)
                .background(Capsule().fill(backgroundColor))
        )
        .foregroundStyle(textColor)
    }
}
