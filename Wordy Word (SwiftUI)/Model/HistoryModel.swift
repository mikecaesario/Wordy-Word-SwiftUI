//  
//  HistoryModel.swift
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

struct HistoryItems: Codable {    
    let date: Date
    var items: [EditHistoryItem]
}

struct EditHistoryItem: Codable {    
    let uneditedItem: String
    var result: [EditHistoryItemResults]
}

struct EditHistoryItemResults: Codable {
    let timeStamp: Date
    let style: String
    let result: String
}
