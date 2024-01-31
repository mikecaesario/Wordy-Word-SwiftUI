//  
//  SavedHistorySettingsCell.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 15/11/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct SavedHistorySettingsCell: View {
    
    @EnvironmentObject private var viewModel: AppViewModel
    
    private let label = "Saved History"
    private let moreInfoText = "Adjust the maximum limit of historical data to be stored."
        
    var body: some View {
        
        ZStack {
            
            VStack(spacing: 10) {
                
                HStack {
                    
                    Text(label)
                        .font(.custom(.fonts.poppinsMedium, size: 20))

                    Spacer()
                    
                    Text("\(viewModel.maxHistoryDataLimit)")
                        .font(.custom(.fonts.poppinsSemiBold, size: 20))
                }
                .foregroundStyle(Color.text.white)
                .lineLimit(1)
                .minimumScaleFactor(0.8)

                CustomSlider(value: viewModel.$maxHistoryDataLimit, maxValue: 25)
                    .frame(height: 60)
                
                Text(moreInfoText)
                    .foregroundStyle(Color.text.grey)
                                
            }
            .padding(18)
            .foregroundStyle(Color.text.white)
            
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.background.thirtiary)
        )
    }
}

#Preview {
    SavedHistorySettingsCell()
        .environmentObject(MockViewModel.shared.viewModel)
}
