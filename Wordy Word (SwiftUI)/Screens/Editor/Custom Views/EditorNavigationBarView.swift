//  
//  EditorNavigationBarView.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 30/10/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct EditorNavigationBarView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    @State private var screenSize: CGSize = .zero
    
    var body: some View {
        
        ZStack {
            
            HStack {
                
                Text(viewModel.editingStyle?.titleName ?? "Wordy Word")
                    .font(Font.custom(.fonts.poppinsMedium, size: 38))
                    .foregroundStyle(Color.text.white)
                    .padding(.leading)
                    
                Spacer()
                
                NavigationBarCircleButtonView(symbolName: "slider.horizontal.3", backgroundColor: .background.thirtiary) {
                    
                    withAnimation {
                        viewModel.showEditorStylePicker = true
                    }
                }
                .frame(maxWidth: screenSize.height * 0.75, maxHeight: screenSize.height * 0.75)
                .padding(.trailing)
                
            }
            .background(
                LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.25), Gradient.Stop(color: .background.primary, location: 0.9)], startPoint: .bottom, endPoint: .top)
            )
            .frame(height: 70)
            .getViewSize($screenSize)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    EditorNavigationBarView()
        .environmentObject(MockViewModel.shared.viewModel)
}

struct NavigationBarCircleButtonView: View {
    
    let symbolName: String
    let backgroundColor: Color
    let onButtonPress: () -> ()
    
    var body: some View {
        
        Button {
            onButtonPress()
        } label: {
            
            Image(systemName: symbolName)
                .resizable()
                .scaledToFit()
                .font(Font.system(size: 20, weight: .light))
                .imageScale(.small)
                .foregroundStyle(Color.text.white)
                .padding()
                .background(Circle().fill(backgroundColor))
        }
    }
}
