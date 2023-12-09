//  
//  HistoryView.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 06/11/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct HistoryView: View {
    
    @Binding var currentModalPresentationDetent: PresentationDetent
    
    let historyData: [HistoryItems]
    
    var body: some View {
       
        NavigationView {
            
            ZStack {
                
                if historyData.isEmpty {
                    noHistory
                } else {
                    historyList
                }
                
                NavigationTitleView(title: "History")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(Color.background.primary)
            .navigationBarHidden(true)
        }
        .onDisappear {
            self.currentModalPresentationDetent = .medium
        }
    }
}

#Preview {
    
    let data = MockViewModel.previewData
    return HistoryView(currentModalPresentationDetent: .constant(.large), historyData: data)
}

extension HistoryView {
    
    var historyList: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            LazyVStack(spacing: 15) {
                
                ForEach(historyData, id: \.date) { history in
                    
                    Text(DateFormatter.formattedDateInFull.string(from: history.date))
                        .font(.custom(.fonts.poppinsMedium, size: 20))
                        .foregroundStyle(Color.text.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ForEach(history.items, id: \.uneditedItem) { item in
                        
                        NavigationLink {
                            EditHistoryView(currentModalPresentationDetent: $currentModalPresentationDetent, editHistoryItem: item)
                        } label: {
                            HistoryCellView(history: item)
                        }
                    }
                }
            }
            .padding(.bottom, 20)
            .padding(.horizontal, 18)
            .padding(.top, 105)
        }
    }
    
    var noHistory: some View {
        
        Text("No History")
            .font(.custom(.fonts.poppinsMedium, size: 20))
            .foregroundStyle(Color.text.grey)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

