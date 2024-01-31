//  
//  HistoryCellView.swift
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

struct HistoryCellView: View {
    
    let history: EditHistoryItem
    
    @State private var cellSize: CGSize = .zero
    
    var body: some View {
        
            
            ZStack {
                
                Text(history.uneditedItem)
                    .font(.custom(.fonts.poppinsMedium, size: 17))
                    .foregroundStyle(Color.text.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(7)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .getViewSize($cellSize)
            .background(
                
                RoundedRectangle(cornerRadius: 30, style: .circular)
                    .foregroundStyle(Color.background.thirtiary)
            )
    }
}

#Preview {
    
    let data = MockViewModel.previewData[0].items[0]
    return HistoryCellView(history: data)
}
