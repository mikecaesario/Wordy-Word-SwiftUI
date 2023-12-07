//  
//  Color+Ext.swift
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
import SwiftUI

extension Color {
    
    struct background {
        static let primary = Color("PrimaryBackgroundColor")
        static let secondary = Color("SecondaryBackgoundColor")
        static let thirtiary = Color("ThirtiaryBackgroundColor")
        static let quarternary = Color("QuarternaryBackgroundColor")
    }
    
    struct accents {
        static let secondary = Color("SecondaryAccentColor")
    }
    
    struct button {
        static let primary = Color("ButtonPrimaryColor")
        static let secondary = Color("ButtonSecondaryColor")
        static let strokeLight = Color("ButtonStrokeLightColor")
        static let strokeDark = Color("ButtonStrokeDarkColor")
        static let copy = Color( "CopyButtonColor")
        static let paste = Color( "PasteButtonColor")
        static let cancel = Color( "CancelButtonColor")
    }
    
    struct text {
        static let editor = Color("EditorTextColor")
        static let white = Color("WhiteTextColor")
        static let black = Color("BlackTextColor")
        static let grey = Color("GreyTextColor")
    }
}
