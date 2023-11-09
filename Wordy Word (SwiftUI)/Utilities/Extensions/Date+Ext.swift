//  
//  Date+Ext.swift
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

extension Date {
    
    func isSameDayAs(otherDate: Date) -> Bool {
        
        let calendar = Calendar.current
        
        let date1 = calendar.dateComponents([.day, .month, .year], from: self)
        let date2 = calendar.dateComponents([.day, .month, .year], from: otherDate)
        
        return date1 == date2
    }
}
