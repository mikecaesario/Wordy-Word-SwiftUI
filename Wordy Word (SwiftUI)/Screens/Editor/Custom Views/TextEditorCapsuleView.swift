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
    
    var body: some View {
        
        ZStack {
           
            TextEditor(text: $viewModel.editingText)
                .disableTextEditorBackground()
                .padding()
                .font(.title)
                .tint(.black)
                .foregroundStyle(.black)

            buttonAndLabelScrollView
                .frame(height: 60)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, 16)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.quarternary)
        .cornerRadius(50)
        .onChange(of: viewModel.editingText) { text in
            
        }
    }
}

#Preview {
    
    TextEditorCapsuleView()
        .environmentObject(MockViewModel.shared.viewModel)
       
}

extension TextEditorCapsuleView {
    
    var buttonAndLabelScrollView: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(spacing: 3) {
                
                PillButtonImageWithText(imageName: "doc.on.clipboard", withLabel: "Paste", labelColor: .text.white, backgroundColor: .button.paste, strokeColor: nil) {
                    viewModel.copyToClipboard()
                }
                
                PillLabelWithStroke(count: viewModel.editingTextCharacterCount, text: viewModel.editingTextCharacterCount > 1 ? "Character" : "Characters", textColor: .text.black, backgroundColor: .background.quarternary, borderColor: .text.black)
                
                PillLabelWithStroke(count: viewModel.editingTextWordCount, text: viewModel.editingTextWordCount > 1 ? "Word" : "Words", textColor: .text.black, backgroundColor: .background.quarternary, borderColor: .text.black)
                
                PillLabelWithStroke(count: viewModel.editingTextSentenceCount, text: viewModel.editingTextSentenceCount > 1 ? "Sentence" : "Sentences", textColor: .text.black, backgroundColor: .background.quarternary, borderColor: .text.black)
                
                PillLabelWithStroke(count: viewModel.editingTextParagraphCount, text: viewModel.editingTextParagraphCount > 1 ? "Paragraph" : "Paragraphs", textColor: .text.black, backgroundColor: .background.quarternary, borderColor: .text.black)
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
