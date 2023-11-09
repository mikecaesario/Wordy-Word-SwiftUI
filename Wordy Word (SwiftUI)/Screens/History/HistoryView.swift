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
    
    @EnvironmentObject var viewModel: AppViewModel
    
    
    var body: some View {
       
        NavigationView {
            
            ZStack {
                
                if viewModel.historyData.isEmpty {
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
    }
}

#Preview {
    HistoryView()
        .environmentObject(MockViewModel.shared.viewModel)
}

extension HistoryView {
    
    var historyList: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            LazyVStack {
                
                ForEach(viewModel.historyData, id: \.date) { history in
                    
                    Text("\(history.date)")
                        .font(.custom(.fonts.poppinsMedium, size: 20))
                        .foregroundStyle(Color.text.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 18)
                    
                    ForEach(history.items, id: \.uneditedItem) { item in
                        
                        NavigationLink {
                            EmptyView()
                        } label: {
                            HistoryCellView(history: item)
                        }
                    }
                }
            }
        }
    }
    
    var noHistory: some View {
        
        Text("No History")
            .font(.custom(.fonts.poppinsMedium, size: 20))
            .foregroundStyle(Color.text.grey)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

