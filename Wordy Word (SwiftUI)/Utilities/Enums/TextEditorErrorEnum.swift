//  
//  TextEditorErrorEnum.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 24/10/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import Foundation

enum EditingTextError: Error {
    
    case noTextInput, editingStyleIsNotSelected, findTextIsEmpty, replaceTextIsEmpty, removeIsEmpty
    
    var localizedDescription: String {
        
        switch self {
            
        case .noTextInput:
             NSLocalizedString("There are no text available to be edited", comment: "")

        case .editingStyleIsNotSelected:
             NSLocalizedString("Editing style hasn't been selected", comment: "")

        case .findTextIsEmpty:
             NSLocalizedString("Enter find text before continuing", comment: "")
            
        case .replaceTextIsEmpty:
             NSLocalizedString("Enter replacing text before continuing", comment: "")

        case .removeIsEmpty:
             NSLocalizedString("Remove character is empty", comment: "")

        }
    }
}
