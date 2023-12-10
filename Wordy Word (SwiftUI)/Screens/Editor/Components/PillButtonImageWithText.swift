//  
//  PillButtonImageWithText.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 02/12/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct PillButtonImageWithText: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    let defaultSymbol: String
    let defaultLabel: String
    let labelColor: Color
    let backgroundColor: Color
    
    let onSuccessSymbol: String
    let onSuccessLabel: String
    let onSuccessLabelColor: Color
    let onSuccessBackgroundColor: Color
    let strokeColor: Color
    
    let type: ButtonType
    
    public enum ButtonType {
        case paste, copy
    }
        
    @State private var backPillDegree: Double = 90
    @State private var frontPillDegree: Double = 0
    
    private func flipButton() {
        
        withAnimation(.easeInOut(duration: 0.3)) {
            frontPillDegree = -90
        }
        
        withAnimation(.easeInOut(duration: 0.3).delay(0.3)) {
            backPillDegree = 0
        }
        
        withAnimation(.easeInOut(duration: 0.3).delay(1.2)) {
            backPillDegree = 90
        }
        
        withAnimation(.easeInOut(duration: 0.3).delay(1.5)) {
            frontPillDegree = 0
        }
    }
    
    var body: some View {
        
        Button {
            
            switch type {
            case .paste:
                
                viewModel.pasteFromClipboard { success in
                    
                    if success {
                        
                        flipButton()
                    }
                }
            case .copy:
                
                viewModel.copyResultToClipboard { success in
                    
                    if success {
                        
                        flipButton()
                    }
                }
            }
            
        } label: {
            
            ZStack {
                
                OnSuccessPillButtonView(imageName: onSuccessSymbol, withLabel: onSuccessLabel, labelColor: onSuccessLabelColor, backgroundColor: onSuccessBackgroundColor, strokeColor: strokeColor)
                    .rotation3DEffect(
                        .degrees(backPillDegree),
                        axis: (x: 1.0, y: 0.0, z: 0.0)
                    )
                
                DefaultPillButtonView(imageName: defaultSymbol, withLabel: defaultLabel, labelColor: labelColor, backgroundColor: backgroundColor)
                    .rotation3DEffect(
                    .degrees(frontPillDegree),
                            axis: (x: 1.0, y: 0.0, z: 0.0)
                )
            }
        }
    }
}


#Preview {
    PillButtonImageWithText(defaultSymbol: "doc.on.clipboard",
                            defaultLabel: "Paste",
                            labelColor: .text.white,
                            backgroundColor: .button.paste,
                            
                            onSuccessSymbol: "checkmark",
                            onSuccessLabel: "Pasted",
                            onSuccessLabelColor: .text.black,
                            onSuccessBackgroundColor: .background.quarternary,
                            strokeColor: .text.black, type: .paste)
    .environmentObject(MockViewModel.shared.viewModel)
}
