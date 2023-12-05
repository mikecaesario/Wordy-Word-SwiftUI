//  
//  EditingStylePickerView.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 02/11/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct EditingStylePickerView: View {
    
    @EnvironmentObject private var viewModel: AppViewModel
    
    @State private var animate = false
    
    private let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
               
                VStack {
                    
                    Text("Select Style")
                        .font(Font.custom(.fonts.poppinsMedium, size: 28))
                        .foregroundStyle(Color.text.white)
                        .minimumScaleFactor(0.7)
                    
                    Spacer()
                    
                    let itemSize = (geo.size.width / 4) / 2
                    let itemSpacing = (geo.size.width / 4) / 4
                    let widthSize = (geo.size.width / 2)
                    
                    LazyVGrid(columns: columns, alignment: .center, spacing: 15) {
                        
                        ForEach(EditingStyleEnum.allCases, id: \.self) { style in
                            
                            let lastItem = style ==  EditingStyleEnum.reverse
                            
                            EditorMenuItemGrid(style: style, isCurrentlySelected: style == viewModel.editingStyle) {
                                
                                didFinishPickingEditingStyle(style: style)
                                
                            }
                            .frame(height: (geo.size.width / 4) + 20)
                            .frame(maxWidth: geo.size.width / 4)
                            .offset(x: lastItem ? (widthSize - itemSize) - itemSpacing : 0)
                        }
                    }
                    .opacity(animate ? 1.0 : 0.0)
                    .scaleEffect(CGSize(width: animate ? 1.0 : 0.9, height: animate ? 1.0 : 0.9))
                    .animation(.easeIn(duration: 0.1), value: animate)
                    
                    
                    Spacer()
                    
                    EditingStyleCircularButton {
                        
                        viewModel.showEditorStylePicker = false
                    }
                    .frame(maxWidth: geo.size.width / 4, maxHeight: geo.size.width / 4)
                    
                }
                .padding()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.thinMaterial)
            .onAppear {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    animate = true
                }
            }
        }
    }
}

#Preview {
    EditingStylePickerView()
        .environmentObject(MockViewModel.shared.viewModel)
        .environment(\.colorScheme, .dark)
}

extension EditingStylePickerView {
    
    private func didFinishPickingEditingStyle(style: EditingStyleEnum) {
        
        let haptic = UIImpactFeedbackGenerator(style: .medium)
        
        viewModel.showEditorStylePicker = false
        viewModel.editingStyle = style
        
        haptic.impactOccurred()
    }
}
