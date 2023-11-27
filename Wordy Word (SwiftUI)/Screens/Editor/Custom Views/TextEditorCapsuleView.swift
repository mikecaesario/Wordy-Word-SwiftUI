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
                .onAppear { viewModel.editingText = placeholderText }
                .onChange(of: viewModel.editingText) { text in
                    
                    if text.last == "\n" {
                        
                        isFocused = nil
                        
                        let endIndex = viewModel.editingText.index(before: viewModel.editingText.endIndex)
                        
                        viewModel.editingText.remove(at: endIndex)
                        
                        viewModel.beginEditingText()
                    }
                }
                .onChange(of: isFocused) { focus in
                    
                    if focus == nil {
                        
                        if viewModel.editingText.isEmpty || viewModel.editingText == " " || viewModel.editingText == "\n" {
                            viewModel.editingText = placeholderText
                        }
                    }
                }
                

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
                
                PillButtonImageWithText(defaultSymbol: "doc.on.clipboard",
                                        defaultLabel: "Paste",
                                        labelColor: .text.white,
                                        backgroundColor: .button.paste,
                                        
                                        onSuccessSymbol: "checkmark",
                                        onSuccessLabel: "Pasted",
                                        onSuccessLabelColor: .text.black,
                                        onSuccessBackgroundColor: .background.quarternary,
                                        strokeColor: .text.black) {
                    
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
    
    let defaultSymbol: String
    let defaultLabel: String
    let labelColor: Color
    let backgroundColor: Color
    
    let onSuccessSymbol: String
    let onSuccessLabel: String
    let onSuccessLabelColor: Color
    let onSuccessBackgroundColor: Color
    let strokeColor: Color
    
    let onButtonPress: () -> ()
    
    @State private var backPillDegree: Double = 90
    @State private var frontPillDegree: Double = 0
    
    private func flipButton() {
        
        withAnimation(.easeInOut(duration: 0.3)) {
            frontPillDegree = -90
        }
        
        withAnimation(.easeInOut(duration: 0.3).delay(0.3)) {
            backPillDegree = 0
        }
        
        withAnimation(.easeInOut(duration: 0.3).delay(1.2)) {
            backPillDegree = 90
        }
        
        withAnimation(.easeInOut(duration: 0.3).delay(1.5)) {
            frontPillDegree = 0
        }
    }
    
    var body: some View {
        
        Button {
            
            onButtonPress()
            flipButton()
            
        } label: {
            
            ZStack {
                
                OnSuccessPillButtonView(imageName: onSuccessSymbol, withLabel: onSuccessLabel, labelColor: onSuccessLabelColor, backgroundColor: onSuccessBackgroundColor, strokeColor: strokeColor)
                    .rotation3DEffect(
                        .degrees(backPillDegree),
                        axis: (x: 1.0, y: 0.0, z: 0.0)
                    )
                
                DefaultPillButtonView(imageName: defaultSymbol, withLabel: defaultLabel, labelColor: labelColor, backgroundColor: backgroundColor)
                    .rotation3DEffect(
                    .degrees(frontPillDegree),
                            axis: (x: 1.0, y: 0.0, z: 0.0)
                )
            }
        }
    }
}

struct DefaultPillButtonView: View {
    
    let imageName: String
    let withLabel: String
    let labelColor: Color
    let backgroundColor: Color
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 10) {
            
            Image(systemName: imageName)
            Text(withLabel)
        }
        .font(Font.custom(.fonts.poppinsMedium, size: 16))
        .foregroundStyle(labelColor)
        .frame(maxHeight: .infinity)
        .padding([.leading, .trailing], 25)
        .frame(width: 130)
        .background(
            Capsule()
                .foregroundStyle(backgroundColor)
        )
        .font(.system(size: 16))
    }
}

struct OnSuccessPillButtonView: View {
    
    let imageName: String
    let withLabel: String
    let labelColor: Color
    let backgroundColor: Color
    let strokeColor: Color
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 10) {
            
            Image(systemName: imageName)
            Text(withLabel)
        }
        .font(Font.custom(.fonts.poppinsMedium, size: 16))
        .foregroundStyle(labelColor)
        .frame(maxHeight: .infinity)
        .frame(width: 130)
        .background(
            Capsule()
                .strokeBorder(strokeColor ,lineWidth: 1.0)
                .background(Capsule().fill(backgroundColor))
        )
        .font(.system(size: 16))
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
