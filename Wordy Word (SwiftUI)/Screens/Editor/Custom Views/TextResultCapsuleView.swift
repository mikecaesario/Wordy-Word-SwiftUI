//  
//  TextResultCapsuleView.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 29/10/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct TextResultCapsuleView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @State private var viewSize: CGPoint = .zero
    
    var body: some View {
        
        ZStack {
           
            ScrollView(.vertical, showsIndicators: false) {
                
                Text(viewModel.textResult)
                    .font(Font.custom(.fonts.poppinsSemiBold, size: 28))
                    .foregroundStyle(Color.text.white)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.bottom, .horizontal], 25)
                    .padding(.top, 85)
            }

            buttonAndLabelScrollView
                .frame(height: 60)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.top, 16)
            
        }
        .environmentObject(viewModel)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.secondary)
        .cornerRadius(50)
    }
}

#Preview {
    TextResultCapsuleView()
        .environmentObject(MockViewModel.shared.viewModel)
}

extension TextResultCapsuleView {
    
    var buttonAndLabelScrollView: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(spacing: 3) {
                
                PillButtonImageWithText(defaultSymbol: "doc.on.doc",
                                        defaultLabel: "Copy",
                                        labelColor: .text.white,
                                        backgroundColor: .button.copy,
                                        
                                        onSuccessSymbol: "checkmark",
                                        onSuccessLabel: "Copied",
                                        onSuccessLabelColor: .text.white,
                                        onSuccessBackgroundColor: .background.secondary,
                                        strokeColor: .text.grey, type: .copy)
                
                PillLabelWithStroke(count: viewModel.editingTextCharacterCount, text: viewModel.editingTextCharacterCount > 1 ? "Characters" : "Character", textColor: .text.white, backgroundColor: .background.secondary, borderColor: .text.grey)
                
                PillLabelWithStroke(count: viewModel.editingTextWordCount, text: viewModel.editingTextWordCount > 1 ? "Words" : "Word", textColor: .text.white, backgroundColor: .background.secondary, borderColor: .text.grey)
                
                PillLabelWithStroke(count: viewModel.editingTextSentenceCount, text: viewModel.editingTextSentenceCount > 1 ? "Sentences" : "Sentence", textColor: .text.white, backgroundColor: .background.secondary, borderColor: .text.grey)
                
                PillLabelWithStroke(count: viewModel.editingTextParagraphCount, text: viewModel.editingTextParagraphCount > 1 ? "Paragraphs" : "Paragraph", textColor: .text.white, backgroundColor: .background.secondary, borderColor: .text.grey)
            }
            .padding([.leading, .trailing], 16)
        }
    }

}
