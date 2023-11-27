//  
//  CustomSlider.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 14/11/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct CustomSlider: View {
    
    @Binding var value: Int
    let maxValue: Int
        
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack(alignment: .leading) {
                
                Capsule()
                    .fill(Color.background.secondary)
                    .frame(height: 12)
                    .frame(maxWidth: geo.size.width)
                
                Capsule()
                    .fill(Color.background.quarternary)
                    .frame(height: 12)
                    .frame(width: geo.size.width * (CGFloat(value) / CGFloat(maxValue)))
                
                Circle()
                    .fill(Color.background.quarternary)
                    .frame(width: 25, height: 25)
                    .offset(x: value >= (maxValue / 2) ? geo.size.width * (CGFloat(value) / CGFloat(maxValue)) - 25 : geo.size.width * (CGFloat(value) / CGFloat(maxValue)) - 12.5)
                    .gesture(
                        
                        DragGesture()
                            .onChanged { dragValue in
                                
                                if dragValue.location.x >= 12.5 &&
                                    dragValue.location.x <= geo.size.width {
                                    
                                    let newValue = round(CGFloat(maxValue) * (CGFloat(dragValue.location.x) / CGFloat(geo.size.width)))
                                    
                                    value = Int(newValue)
                                }
                            }
                    )
            }
            .frame(height: 60)
            .frame(maxWidth: .infinity)
        }
    }
}


#Preview {
    CustomSlider(value: .constant(5), maxValue: 25)
}
