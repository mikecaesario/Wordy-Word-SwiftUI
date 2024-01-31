//  
//  EditingStyleCircularButton.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 05/12/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct EditingStyleCircularButton: View {
        
    let onButtonPress: () -> ()
    
    var body: some View {
        
        Button {
            onButtonPress()
            
        } label: {
            
            ZStack {
                
                Circle()
                    .fill(Color.button.cancel)
                
                Image(systemName: "xmark")
                    .font(.system(size: 28, weight: .medium))
                    .imageScale(.medium)
                    .padding()
                    .foregroundStyle(Color.text.black)
            }
        }
    }
}


#Preview {
    EditingStyleCircularButton() {
        
    }
}
