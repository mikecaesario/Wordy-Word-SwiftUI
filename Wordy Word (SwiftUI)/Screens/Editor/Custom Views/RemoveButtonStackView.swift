//  
//  RemoveButtonStackView.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 04/11/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct RemoveButtonStackView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(spacing: 3) {
                
                ForEach(viewModel.removeCharacterArrayButtons, id: \.self) { char in
                    
                    PillButtonWithStroke(character: char, isCurrentlySelected: isCharacterExistInTheArray(char: char)) {
                        
                        // Check if the character already existed in the array
                        if viewModel.removeCharacterArray.contains(char) {
                            
                            // Get the exact index of the selected character from the array
                            if let index = viewModel.removeCharacterArray.firstIndex(of: char) {
                                
                                // Remove it from the array
                                viewModel.removeCharacterArray.remove(at: index)
                            }
                            
                        } else {
                            
                            // If the character didn't exist, add it to the array
                            viewModel.removeCharacterArray.append(char)
                        }
                    }
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 18)
        }
        .frame(height: 60)
    }
}

#Preview {
    RemoveButtonStackView()
        .environmentObject(MockViewModel.shared.viewModel)
}

extension RemoveButtonStackView {
    
    private func isCharacterExistInTheArray(char: String) -> Bool {
        
        if viewModel.removeCharacterArray.contains(char) {
            
            return true
        } else {
            
            return false
        }
    }
}

struct PillButtonWithStroke: View {
    
    let character: String
    let isCurrentlySelected: Bool
    let onButtonPress: () -> ()
    
    var body: some View {
        
        Button {
            
            onButtonPress()
        } label: {
            
            Text(character)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(isCurrentlySelected ? Color.text.black : Color.text.grey)
        }
        .padding()
        .frame(width: 90, height: 55)
        .background(
            Capsule()
                .foregroundStyle(isCurrentlySelected ?  Color.background.quarternary : .clear)
                .background(
                    Capsule()
                        .stroke(isCurrentlySelected ? Color.background.quarternary : Color.button.strokeLight, lineWidth: 1.0)
                )
        )
    }
}
