//  
//  DetailedOriginalTextView.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 09/11/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct DetailedOriginalTextView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let originalText: String
    
    var body: some View {
        ZStack {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                Text(originalText)
                    .font(.custom(.fonts.poppinsMedium, size: 22))
                    .foregroundStyle(Color.text.white)
                    .multilineTextAlignment(.leading)
                    .textSelection(.enabled)
                    .padding(.horizontal)
                    .padding(.vertical, 105)
            }
            
            DetailedHistoryNavigationBarButtonsView { action in
                
                switch action {
                case .back:
                    dismiss()
                case .copy:
                    UIPasteboard.general.string = originalText
                }
            }

            footer
        }
        .navigationBarHidden(true)
        .background(
            Color.background.primary
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    let data = MockViewModel.previewData[0].items[0].uneditedItem
    return DetailedOriginalTextView(originalText: data)
}

extension DetailedOriginalTextView {
    
    var footer: some View {
        
        ZStack {
            
            Text("Original")
                .font(.custom(.fonts.poppinsSemiBold, size: 22))
                .foregroundStyle(Color.text.white)
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
        .padding()
        .background(
            LinearGradient(stops: [Gradient.Stop(color: .background.primary, location: 0.6), Gradient.Stop(color: .clear, location: 0.3)], startPoint: .top, endPoint: .bottom)
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
}
