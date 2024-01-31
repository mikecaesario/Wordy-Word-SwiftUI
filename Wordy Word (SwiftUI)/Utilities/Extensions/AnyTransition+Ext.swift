//  
//  AnyTransition+Ext.swift
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

extension AnyTransition {
    
    static var fadeAndMoveUp: AnyTransition {
        AnyTransition.opacity.combined(with: .move(edge: .bottom))
    }
    
    static var fadeAndMoveDown: AnyTransition {
        AnyTransition.opacity.combined(with: .move(edge: .top))
    }
}
