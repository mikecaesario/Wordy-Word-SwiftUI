//  
//  DetailedHistoryNavigationBarButtonsView.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 28/11/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct DetailedHistoryNavigationBarButtonsView: View {
    
    let onButtonPress: (NavigationBarButtonEnum) -> ()
    
    @State private var viewSize: CGSize = .zero
    
    @State private var backButtonDegrees: Double = 90
    @State private var frontButtonDegrees: Double = 0
    
    var body: some View {
        
        ZStack {
            
            HStack {
                
                Button {
                    onButtonPress(.back)
                } label: {
                    NavigationBarCircleButton(symbolName: "chevron.left")
                }
                .frame(maxWidth: viewSize.height * 0.55, maxHeight: viewSize.height * 0.55)
                
                Spacer()
                
                Button {
                    onButtonPress(.copy)
                    animateCopyButton()
                } label: {
                    copyButton
                }
                .frame(maxWidth: viewSize.height * 0.55, maxHeight: viewSize.height * 0.55)
            }
            .padding(.horizontal)
        }
        .frame(height: 100)
        .getViewSize($viewSize)
        .background(
            LinearGradient(stops: [Gradient.Stop(color: .background.primary, location: 0.6), Gradient.Stop(color: .clear, location: 1.0)], startPoint: .top, endPoint: .bottom)
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    
    DetailedHistoryNavigationBarButtonsView { action in
        
        switch action {
        case .back:
            break
        case .copy:
            break
        }
    }
}

extension DetailedHistoryNavigationBarButtonsView {
    
    public enum NavigationBarButtonEnum {
        case back, copy
    }
    
    private var copyButton: some View {
        
        ZStack {
            
            NavigationBarCircleButton(symbolName: "checkmark")
                .rotation3DEffect(
                    .degrees(backButtonDegrees),
                    axis: (x: 1.0, y: 0.0, z: 0.0)
                )
            
            NavigationBarCircleButton(symbolName: "doc.on.doc")
                .rotation3DEffect(
                    .degrees(frontButtonDegrees),
                    axis: (x: 1.0, y: 0.0, z: 0.0)
                )
        }
    }
    
    private func animateCopyButton() {
        
        withAnimation(.easeInOut(duration: 0.3)) {
            frontButtonDegrees = -90
        }
        
        withAnimation(.easeInOut(duration: 0.3).delay(0.3)) {
            backButtonDegrees = 0
        }
        
        withAnimation(.easeInOut(duration: 0.3).delay(1.2)) {
            backButtonDegrees = 90
        }
        
        withAnimation(.easeInOut(duration: 0.3).delay(1.5)) {
            frontButtonDegrees = 0
        }
    }
}
