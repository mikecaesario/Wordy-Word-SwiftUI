//  
//  Wordy_Word__SwiftUI_App.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 23/10/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

@main
struct Wordy_Word__SwiftUI_App: App {
        
    let historyDataManager = HistoryDataManager()
    let textEditorManager = TextEditorManager()
    
    var body: some Scene {
        
        WindowGroup {
            
            TextEditorView(historyDataManager: historyDataManager, textEditorManager: textEditorManager)
        }
    }
}
