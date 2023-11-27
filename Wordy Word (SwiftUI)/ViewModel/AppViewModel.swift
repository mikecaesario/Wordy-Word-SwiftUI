//  
//  AppViewModel.swift
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
import SwiftUI

public enum whichTextfieldOrTextEditorIsFocused {
    case editor, find, replace
}

final class AppViewModel: ObservableObject {
    
    @Published var historyData: [HistoryItems] = []
    @Published var editingStyle: EditingStyleEnum? {
        didSet {
            showViewIfNeeded(style: editingStyle)
        }
    }
    
    @Published var editingText = ""
    @Published private(set) var textResult = ""
        
    @Published var findText = ""
    @Published var replaceWithText = ""
    @Published var removeCharacterArray: [String] = []
    
    @Published private(set) var editingTextCharacterCount = 0
    @Published private(set) var editingTextWordCount = 0
    @Published private(set) var editingTextSentenceCount = 0
    @Published private(set) var editingTextParagraphCount = 0
    
    @Published private(set) var textResultCharacterCount = 0
    @Published private(set) var textResultWordCount = 0
    @Published private(set) var textResultSentenceCount = 0
    @Published private(set) var textResultParagraphCount = 0
    
    @Published var showEditorStylePicker = false
    @Published var showResultView = false
    @Published var showReplaceTextfield = false
    @Published var showRemoveButtonStack = false {
        didSet {
            findText = ""
            replaceWithText = ""
        }
    }
    
    @Published var showTabBarModal: TabBarModalEnum?
    
    @Published var screenSize: CGSize = .zero
    
    @AppStorage("maxHistoryLimit") var maxHistoryDataLimit: Int = 5
    
    let removeCharacterArrayButtons = ["*", "_", "/", "+", "(", ")", "%", "#", "!", "?", "@", "|", "{", "}", ":", ".", ","]
            
    private let historyDataManager: HistoryDataManagerProtocol
    private let textEditorManager: TextEditorManagerProtocol
    
    init(historyDataManager: HistoryDataManagerProtocol, textEditorManager: TextEditorManagerProtocol) {
        
        self.historyDataManager = historyDataManager
        self.textEditorManager = textEditorManager
        
        registerDefaults()
        
        self.historyData = historyDataManager.fetchHistoryItemsFromJSON()
    }
    
    private func registerDefaults() {
        
    }
    
    func copyToClipboard() {
        
    }
    
    func beginEditingText() {
        
    }
    
    private func showViewIfNeeded(style: EditingStyleEnum?) {
                
        switch style {
        case .replace:
            showReplaceTextfield = true
            showRemoveButtonStack = false
            print("SHOWING REPLACE")
        case .remove:
            showReplaceTextfield = false
            showRemoveButtonStack = true
            print("SHOWING REMOVE")

        default:
            showReplaceTextfield = false
            showRemoveButtonStack = false
        }
    }
}
