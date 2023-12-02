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
    
    @State private var temporaryRemoveCharacterArrayInput: [String] = []
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(spacing: 3) {
                
                ForEach(viewModel.removeCharacterArrayButtons, id: \.self) { char in
                    
                    PillButtonWithStroke(character: char, isCurrentlySelected: isCharacterExistInTheArray(char: char)) {
                        
                        addOrRemoveSelectedCharacterFromTheArray(char: char)
                    }
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 18)
        }
        .frame(height: 60)
        .onChange(of: temporaryRemoveCharacterArrayInput) { newInput in
            
            viewModel.removeCharacterArray = newInput
        }
    }
}

#Preview {
    RemoveButtonStackView()
        .environmentObject(MockViewModel.shared.viewModel)
}

extension RemoveButtonStackView {
    
    private func isCharacterExistInTheArray(char: String) -> Bool {
        
        if temporaryRemoveCharacterArrayInput.contains(char) {
            
            return true
        } else {
            
            return false
        }
    }
    
    private func addOrRemoveSelectedCharacterFromTheArray(char: String) {
        
        // Check if the character already existed in the array
        if temporaryRemoveCharacterArrayInput.contains(char) {
            
            // Get the exact index of the selected character from the array
            if let index = temporaryRemoveCharacterArrayInput.firstIndex(of: char) {
                
                // Remove it from the array
                temporaryRemoveCharacterArrayInput.remove(at: index)
            }
            
        } else {
            
            // If the character didn't exist, add it to the array
            temporaryRemoveCharacterArrayInput.append(char)
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
