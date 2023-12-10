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

public enum ToastType {
    case paste, copy, error
    
    var symbol: String {
        
        switch self {
        case .paste:
            "exclamationmark.triangle.fill"
        case .copy:
            "checkmark"
        case .error:
            "exclamationmark.triangle.fill"
        }
    }
    
    var message: String {
        
        switch self {
        case .paste:
            "There are no item to be pasted from the clipboard"
        case .copy:
            "Text has been successfully copied to clipboard"
        case .error:
            "Whoops! Something went wrong, please try again later"
        }
    }
}

final class AppViewModel: ObservableObject {
    
    @Published var historyDataArray: [HistoryItems] = []
    
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
        
    @Published var findText: String = ""
    @Published var replaceWithText: String = ""
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
    @Published var showRemoveButtonStack = false 
    
    @Published var showTabBarModal: TabBarModalEnum?
    
    @Published var showToast = false
    @Published private(set) var toastType: ToastType = .error
        
    @AppStorage("maxHistoryLimit") var maxHistoryDataLimit: Int = 5
    
    let removeCharacterArrayButtons = ["*", "_", "/", "+", "(", ")", "%", "#", "!", "?", "@", "|", "{", "}", ":", ".", ","]
            
    private let historyDataManager: HistoryDataManagerProtocol
    private let textEditorManager: TextEditorManagerProtocol
    
    init(historyDataManager: HistoryDataManagerProtocol, textEditorManager: TextEditorManagerProtocol) {
        
        self.historyDataManager = historyDataManager
        self.textEditorManager = textEditorManager
                
        self.historyDataArray = historyDataManager.fetchHistoryItemsFromJSON()
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
    
    func copyResultToClipboard(completion: (Bool) -> ()) {
        
        UIPasteboard.general.string = textResult
        showToast(withType: .copy)
        completion(true)
    }
    
    func pasteFromClipboard(completion: (Bool) -> ()) {
        
        guard let pasteboardData = UIPasteboard.general.string else {
            
            return
        }
        
        if pasteboardData != " " || pasteboardData != ""  {
            
            editingText = pasteboardData
            completion(true)
            beginEditingText()
        } else {
            
            showToast(withType: .paste)
        }
    }
    
    func beginEditingText() {
        
        guard editingText != "", let style = editingStyle else { return }
        
        let haptics = UIImpactFeedbackGenerator(style: .rigid)

        do {
            
            let result = try textEditorManager.startEditText(text: editingText, editingStyle: editingStyle, remove: removeCharacterArray, find: findText, replace: replaceWithText)
            
            self.showResultView = false

            textResult = result
            
            historyDataArray = historyDataManager.didFinishEditingNowAppendingHistoryItem(history: historyDataArray, editingText: editingText, editingResult: result, editingStyle: style, withLimit: maxHistoryDataLimit)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) { [weak self] in
                
                guard let self = self else { return }
                self.showResultView = true
            }
            
            historyDataManager.writeHistoryItemsToJSON(history: historyDataArray)
            
            haptics.impactOccurred()
            
        } catch(let error as EditingTextError) {
            
            switch error {
                
            case .findTextIsEmpty, .replaceTextIsEmpty, .removeIsEmpty:
                
                self.showResultView = false
            default:
                
                break
            }
            
        } catch {
            
            showToast(withType: .error)
        }
    }
    
    private func showToast(withType: ToastType) {
        
        if !showToast {
            
            toastType = withType
            showToast = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
                
                guard let self = self else { return }
                self.showToast = false
            }
        }
    }
    
    private func showViewIfNeeded(style: EditingStyleEnum?) {
                
        switch style {
        case .replace:
            
            showReplaceTextfield = true
            showRemoveButtonStack = false
            removeCharacterArray = []
        case .remove:
            
            showReplaceTextfield = false
            showRemoveButtonStack = true
            replaceWithText = ""
            findText = ""
        default:
            
            showReplaceTextfield = false
            showRemoveButtonStack = false
            removeCharacterArray = []
            replaceWithText = ""
            findText = ""
        }
    }
    
    func removeExcessHistoryDataIfNeeded() {
        
        let newChangedLimitHistoryData = historyDataArray.prefix(maxHistoryDataLimit)
        historyDataArray = Array(newChangedLimitHistoryData)
        historyDataManager.writeHistoryItemsToJSON(history: historyDataArray)
    }
}
