//  
//  TabBarModalEnum.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 25/10/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import Foundation

enum TabBarModalEnum: Identifiable {
    
    case history, settings
    
    var id: String {
        
        switch self {
        case .history:
            "History"
        case .settings:
            "Settings"
        }
    }
}
