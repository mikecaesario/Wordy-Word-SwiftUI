//  
//  EditingStylePickerView.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 02/11/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct EditingStylePickerView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @Binding var screenSize: CGSize
    
    var body: some View {
        
        ZStack {
            
            Text("Select Style")
                .font(Font.custom(.fonts.poppinsMedium, size: 28))
                .foregroundStyle(Color.text.white)
                .minimumScaleFactor(0.7)
            
            LazyVGrid(columns: [GridItem, GridItem], alignment: .center, spacing: 10) {
                
                ForEach(EditingStyleEnum.allCases) { style in
                    
                }
            }
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.thinMaterial)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    
    EditingStylePickerView(screenSize: .constant(UIScreen.main.bounds.size))
}
