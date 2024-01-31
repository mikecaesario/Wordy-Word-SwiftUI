//  
//  HistoryDataManager.swift
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

protocol HistoryDataManagerProtocol {
    func fetchHistoryItemsFromJSON() -> [HistoryItems]
    func writeHistoryItemsToJSON(history: [HistoryItems]?)
    func didFinishEditingNowAppendingHistoryItem(history: [HistoryItems], editingText: String, editingResult: String, editingStyle: EditingStyleEnum, withLimit: Int) -> [HistoryItems]
}

class HistoryDataManager: HistoryDataManagerProtocol {
    
    private let fileName = "historyItems.json"
    
    func fetchHistoryItemsFromJSON() -> [HistoryItems] {
        
        guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName) else { return [] }
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let items = try decoder.decode([HistoryItems].self, from: data)
                return items
            } catch {
                return []
            }
            
        } else {
            return []
        }
    }
    
    func writeHistoryItemsToJSON(history: [HistoryItems]?) {
        
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first, let history = history else { return }
        let fileUrl = url.appendingPathComponent(fileName)
                
        do {
            
            let encoder = JSONEncoder()
            let data = try encoder.encode(history)
            try data.write(to: fileUrl)
        } catch {
            fatalError("ERROR: ERROR WRITING HISTORY DATA TO FILE MANAGER")
        }
    }
    
    func didFinishEditingNowAppendingHistoryItem(history: [HistoryItems], editingText: String, editingResult: String, editingStyle: EditingStyleEnum, withLimit: Int) -> [HistoryItems] {
                
        var history = Array(history.suffix(withLimit))
        let currentDate = Date()
        
        if let matchingDate = history.firstIndex(where: { currentDate.isSameDayAs(otherDate: $0.date) }) {
            
            // check to see if the array contains the same String as the current editingText String value
            if let undeditedItemsAlreadyExistsInTheArrayIndex = history[matchingDate].items.firstIndex(where: { $0.uneditedItem == editingText }) {
                
                let newHistoryResult = EditHistoryItemResults(timeStamp: currentDate,
                                                              style: editingStyle.titleName,
                                                              result: editingResult)
                
                history[matchingDate]
                    .items[undeditedItemsAlreadyExistsInTheArrayIndex]
                    .result
                    .insert(newHistoryResult, at: 0)

                return history
            } else {
                
                let newHistoryResult = EditHistoryItemResults(timeStamp: currentDate,
                                                              style: editingStyle.titleName,
                                                              result: editingResult)
                
                let newEditHistoryItem = EditHistoryItem(uneditedItem: editingText,
                                                         result: [newHistoryResult])
                
                history[matchingDate]
                    .items
                    .insert(newEditHistoryItem, at: 0)
                
                return history
            }
            
        } else {
            
            let newHistoryResult = EditHistoryItemResults(timeStamp: currentDate,
                                                          style: editingStyle.titleName,
                                                          result: editingResult)
            
            let newEditHistoryItem = EditHistoryItem(uneditedItem: editingText,
                                                     result: [newHistoryResult])
            
            let newHistoryItems = HistoryItems(date: currentDate,
                                               items: [newEditHistoryItem])
            history
                .insert(newHistoryItems, at: 0)
            
            return history
        }
    }
}

