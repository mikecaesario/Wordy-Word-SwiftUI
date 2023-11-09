//  
//  HistoryHeaderViewModifier.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 09/11/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import Foundation
import SwiftUI

struct HistoryHeaderViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        
        content
            .font(.custom(.fonts.poppinsMedium, size: 20))
            .foregroundStyle(Color.text.grey)
            .lineLimit(1)
            .minimumScaleFactor(0.7)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
