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
                    .padding()
                    .font(Font.custom(.fonts.poppinsSemiBold, size: 28))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(Color.text.white)
            }

            buttonAndLabelScrollView
                .frame(height: 60)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.top, 16)
            
        }
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
                
                PillButtonImageWithText(imageName: "doc.on.doc", withLabel: "Copy", labelColor: .text.white, backgroundColor: .background.quarternary, strokeColor: nil) {
                    
                }
                
                PillLabelWithStroke(count: viewModel.editingTextCharacterCount, text: viewModel.editingTextCharacterCount > 1 ? "Character" : "Characters", textColor: .text.white, backgroundColor: .background.secondary, borderColor: .text.white)
                
                PillLabelWithStroke(count: viewModel.editingTextWordCount, text: viewModel.editingTextWordCount > 1 ? "Word" : "Words", textColor: .text.white, backgroundColor: .background.secondary, borderColor: .text.white)
                
                PillLabelWithStroke(count: viewModel.editingTextSentenceCount, text: viewModel.editingTextSentenceCount > 1 ? "Sentence" : "Sentences", textColor: .text.white, backgroundColor: .background.secondary, borderColor: .text.white)
                
                PillLabelWithStroke(count: viewModel.editingTextParagraphCount, text: viewModel.editingTextParagraphCount > 1 ? "Paragraph" : "Paragraphs", textColor: .text.white, backgroundColor: .background.secondary, borderColor: .text.white)
            }
            .padding([.leading, .trailing], 16)
        }
    }

}
