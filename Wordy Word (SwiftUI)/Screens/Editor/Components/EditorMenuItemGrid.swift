//  
//  EditorMenuItemGrid.swift
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

struct EditorMenuItemGrid: View {
    
    let style: EditingStyleEnum
    let isCurrentlySelected: Bool
    let onGridPressed: () -> ()
    
    var body: some View {
        
        VStack(spacing: 5) {
            
            ZStack {
                
                Circle()
                    .fill(isCurrentlySelected ? Color.button.primary : Color.button.secondary)
                    .aspectRatio(1, contentMode: .fill)
                
                Image(systemName: style.imageName)
                    .font(.system(size: 28, weight: .medium))
                    .imageScale(.medium)
                    .padding()
                    .foregroundStyle(isCurrentlySelected ? Color.text.black : Color.text.white)
            }
            .frame(maxWidth: .infinity)
            
            Text(style.titleName)
                .font(.custom(.fonts.poppinsMedium, size: 14))
                .foregroundStyle(Color.text.white)
        }
        .onTapGesture {
            onGridPressed()
        }
    }
}


#Preview {
    EditorMenuItemGrid(style: .capitalize, isCurrentlySelected: false) {
        
    }
}
