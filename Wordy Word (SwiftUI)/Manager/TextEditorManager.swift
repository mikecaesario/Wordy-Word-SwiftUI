//  
//  TextEditorManager.swift
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

protocol TextEditorManagerProtocol {
    func startEditText(text: String?, editingStyle: EditingStyleEnum?, remove: [String]?, find: String?, replace: String?) throws -> String
}

class TextEditorManager: TextEditorManagerProtocol {
    
    func startEditText(text: String?, editingStyle: EditingStyleEnum?, remove: [String]?, find: String?, replace: String?) throws -> String {
        
        guard let text = text, text != "" else { throw EditingTextError.noTextInput }

        guard let style = editingStyle else { throw EditingTextError.editingStyleIsNotSelected}
                
        var result = ""
        
        switch style {
        case .capitalize:
            result = text.capitalized
        case .title:
            result = text.capitalizeSentences()
        case .upper:
            result = text.uppercased()
        case .lower:
            result = text.lowercased()
        case .replace:
            
            guard let find = find else { throw EditingTextError.findTextIsEmpty }
            
            guard let replace = replace else { throw EditingTextError.replaceTextIsEmpty }
            
            result = text.replaceCharacter(find: find, replaceWith: replace)
        case .remove:
            
            guard let remove = remove else { throw EditingTextError.removeIsEmpty }

            result = text.removeCharacter(remove: remove)
        case .reverse:
            result = String(text.reversed())
        }
        
        return result
    }
}
