//  
//  EditedItemCell.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 05/12/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct EditedItemCell: View {
    
    let editHistoryItemResult: EditHistoryItemResults
    
    @State private var viewSize: CGSize = .zero
    
    var body: some View {
        
        VStack(spacing: 5) {
            
            Text(editHistoryItemResult.result)
                .font(.custom(.fonts.poppinsMedium, size: 16))
                .foregroundStyle(Color.text.white)
                .lineLimit(5)
                .multilineTextAlignment(.leading)
            
            HStack {
                
                Text(DateFormatter.formattedHourFromDate.string(from: editHistoryItemResult.timeStamp))
                    .font(.custom(.fonts.poppinsMedium, size: 12))
                    .foregroundStyle(Color.text.grey)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)

                Spacer()
                
                Text(editHistoryItemResult.style)
                    .font(.custom(.fonts.poppinsMedium, size: 12))
                    .foregroundStyle(Color.text.grey)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)

            }
        }
        .padding()
        .getViewSize($viewSize)
        .background(
            RoundedRectangle(cornerRadius: viewSize.width / 15)
                .foregroundStyle(Color.background.thirtiary)
        )
    }
}


#Preview {
    EditedItemCell(editHistoryItemResult: <#EditHistoryItemResults#>)
}
