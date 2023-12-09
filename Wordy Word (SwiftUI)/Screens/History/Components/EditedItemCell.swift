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
                .frame(maxWidth: .infinity, alignment: .leading)
            
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
        .frame(maxWidth: .infinity)
        .padding()
        .getViewSize($viewSize)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .foregroundStyle(Color.background.thirtiary)
        )
    }
}


#Preview {
    let result = EditHistoryItemResults(timeStamp: .distantPast, style: "Lowercased", result: "lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
   return EditedItemCell(editHistoryItemResult: result)
}
