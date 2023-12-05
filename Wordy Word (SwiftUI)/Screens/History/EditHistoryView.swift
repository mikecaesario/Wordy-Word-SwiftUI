//  
//  EditHistoryView.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 08/11/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct EditHistoryView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var currentModalPresentationDetent: PresentationDetent

    let editHistoryItem: EditHistoryItem
    
    var body: some View {
        
        ZStack {
            
            ScrollView(.vertical, showsIndicators: true) {
                
                LazyVStack(spacing: 20) {
                    
                    Text("Original")
                        .historyHeaderStyle()
                    
                    NavigationLink {
                        
                        DetailedOriginalTextView(originalText: editHistoryItem.uneditedItem)
                    } label: {
                        
                        Text(editHistoryItem.uneditedItem)
                            .font(.custom(.fonts.poppinsMedium, size: 22))
                            .foregroundStyle(Color.text.white)
                            .multilineTextAlignment(.leading)
                            .lineLimit(10)
                    }
                    
                    Text(editHistoryItem.result.count > 1 ? "Edits" : "Edit")
                        .historyHeaderStyle()

                    ForEach(editHistoryItem.result, id: \.timeStamp) { result in
                        
                        NavigationLink {
                            DetailedHistoryResultView(detailedHistory: result)
                        } label: {
                            EditedItemCell(editHistoryItemResult: result)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 105)
            }
            
            EditHistoryNavigationBar(symbolName: "chevron.left") {
                dismiss()
            }
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.primary)
        .onAppear {
            self.currentModalPresentationDetent = .large
        }
    }
}

#Preview {
    
    let data = MockViewModel.previewData[0].items[0]
    return EditHistoryView(currentModalPresentationDetent: .constant(.large), editHistoryItem: data)
}


