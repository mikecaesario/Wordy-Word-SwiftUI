//  
//  EditingStyleEnum.swift
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

public enum EditingStyleEnum: Identifiable, CaseIterable {
    
    /// Possible editing cases
    case capitalize, title, upper, lower, replace, remove, reverse
    
    public var id: Self {
        return self
    }
    
    /// Return string title of the selected enum case
    var titleName: String {
        
        switch self {
        case .capitalize: "Capitalize"
        case .title: "Title"
        case .upper: "Uppercase"
        case .lower: "Lowercase"
        case .replace: "Replace"
        case .remove: "Remove"
        case .reverse: "Reverse"
        }
    }
    
    /// Return SF Symbols glyph name of the selected enum case
    var imageName: String {
        
        switch self {
        case .capitalize: "textformat"
        case .title: "textformat.alt"
        case .upper: "textformat.size.larger"
        case .lower: "textformat.abc"
        case .replace: "character.cursor.ibeam"
        case .remove: "xmark"
        case .reverse: "arrow.left.arrow.right"
        }
    }
}
