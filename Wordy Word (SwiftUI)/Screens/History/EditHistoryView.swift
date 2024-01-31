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
                
                LazyVStack(spacing: 15) {
                    
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
                            .frame(maxWidth: .infinity, alignment: .leading)
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
                .padding(.bottom, 20)
            }
            
            EditHistoryNavigationBar(symbolName: "chevron.left") {
                dismiss()
            }
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.primary)
        .onAppear {

            // added to tackle a weird bug; half of the modal is blocked by a grey view when changing detents on view appear
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.currentModalPresentationDetent = .large
            }
        }
    }
}

#Preview {
    
    let data = MockViewModel.previewData[0].items[0]
    return EditHistoryView(currentModalPresentationDetent: .constant(.large), editHistoryItem: data)
}


