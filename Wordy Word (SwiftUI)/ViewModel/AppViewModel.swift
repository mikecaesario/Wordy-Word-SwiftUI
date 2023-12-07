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
            beginEditingText()
        }
    }
    
    @Published var editingText = "" {
        didSet {
            calculateUneditedText()
        }
    }
    
    @Published private(set) var textResult = "" {
        didSet {
            calculateResultText()
        }
    }
        
    @Published var findText: String? = nil { didSet { beginEditingText() } }
    @Published var replaceWithText: String? = nil { didSet { beginEditingText() } }
    @Published var removeCharacterArray: [String]? = nil { didSet { beginEditingText() } }
    
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
    @Published var showRemoveButtonStack = false 
    
    @Published var showTabBarModal: TabBarModalEnum?
        
    @AppStorage("maxHistoryLimit") var maxHistoryDataLimit: Int = 5
    
    let removeCharacterArrayButtons = ["*", "_", "/", "+", "(", ")", "%", "#", "!", "?", "@", "|", "{", "}", ":", ".", ","]
            
    private let historyDataManager: HistoryDataManagerProtocol
    private let textEditorManager: TextEditorManagerProtocol
    
    init(historyDataManager: HistoryDataManagerProtocol, textEditorManager: TextEditorManagerProtocol) {
        
        self.historyDataManager = historyDataManager
        self.textEditorManager = textEditorManager
                
        self.historyData = historyDataManager.fetchHistoryItemsFromJSON()
    }

    private func calculateUneditedText() {
        
        editingTextCharacterCount =  editingText.count
        editingTextWordCount = editingText.wordCount
        editingTextSentenceCount = editingText.sentenceCount
        editingTextParagraphCount = editingText.count > 1 ? editingText.paragraphsCount() : 0
    }
    
    private func calculateResultText() {
        
        textResultCharacterCount =  textResult.count
        textResultWordCount = textResult.wordCount
        textResultSentenceCount = textResult.sentenceCount
        textResultParagraphCount = textResult.count > 1 ? textResult.paragraphsCount() : 0
    }
    
    func copyResultToClipboard() {
        
        UIPasteboard.general.string = textResult
    }
    
    func pasteFromClipboard() {
        
        if UIPasteboard.general.hasStrings {
            
            if let pasteBoardText = UIPasteboard.general.string {
                
                editingText = pasteBoardText
            }
        }
    }
    
    func beginEditingText() {
        
        guard editingText != "", let style = editingStyle else { return }
        
        let haptics = UIImpactFeedbackGenerator(style: .rigid)

        do {
            
            let result = try textEditorManager.startEditText(text: editingText, editingStyle: editingStyle, remove: removeCharacterArray, find: findText, replace: replaceWithText)
            
            self.showResultView = false

            textResult = result
            
            historyData = historyDataManager.didFinishEditingNowAppendingHistoryItem(history: historyData, editingText: editingText, editingResult: result, editingStyle: style, withLimit: maxHistoryDataLimit)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) { [weak self] in
                
                guard let self = self else { return }
                self.showResultView = true
            }
            
            historyDataManager.writeHistoryItemsToJSON(history: historyData)
            
            haptics.impactOccurred()
            
        } catch(let error as EditingTextError) {
            
            switch error {
            case .findTextIsEmpty, .replaceTextIsEmpty, .removeIsEmpty:
                self.showResultView = false
            default:
                break
            }
            
        } catch {
            
        }
    }
    
    private func showViewIfNeeded(style: EditingStyleEnum?) {
                
        switch style {
        case .replace:
            
            showReplaceTextfield = true
            showRemoveButtonStack = false
            removeCharacterArray = nil
        case .remove:
            
            showReplaceTextfield = false
            showRemoveButtonStack = true
            replaceWithText = nil
            findText = nil
        default:
            
            showReplaceTextfield = false
            showRemoveButtonStack = false
            removeCharacterArray = nil
            replaceWithText = nil
            findText = nil
        }
    }
}
