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
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @State private var lazyVGridSizeScale = CGSize(width: 0.9, height: 0.9)
    @State private var animate = false
    @State private var lazyVGridSize: CGSize = .zero
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                Text("Select Style")
                    .font(Font.custom(.fonts.poppinsMedium, size: 28))
                    .foregroundStyle(Color.text.white)
                    .minimumScaleFactor(0.7)
                
                Spacer()
                
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)], alignment: .center, spacing: 15) {
                    
                    ForEach(EditingStyleEnum.allCases, id: \.self) { style in
                        
                        EditorMenuItemGrid(style: style, isCurrentlySelected: style == viewModel.editingStyle) {
                            
                            viewModel.editingStyle = style
                            
                            withAnimation() {
                                viewModel.showEditorStylePicker = false
                            }
                        }
                        .frame(maxWidth: lazyVGridSize.width * 0.3)
                        .offset(x: style == EditingStyleEnum.reverse ? (lazyVGridSize.width / 2) - ((lazyVGridSize.width * 0.3) / 2) : 0)
                        
                    }
                }
                .getViewSize($lazyVGridSize)
                .opacity(animate ? 1.0 : 0.0)
                .scaleEffect(CGSize(width: animate ? 1.0 : 0.9, height: animate ? 1.0 : 0.9))
                .animation(.default, value: animate)
                .onAppear {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        animate = true
                    }
                }
                
                Spacer()
                
                EditingStyleCircularButton() {
                    
                    withAnimation() {
                        viewModel.showEditorStylePicker = false
                    }
                }
                .frame(maxWidth: lazyVGridSize.width * 0.3, maxHeight: lazyVGridSize.width * 0.3)
                
            }
            .padding(16)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.thinMaterial)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    EditingStylePickerView()
        .environmentObject(MockViewModel.shared.viewModel)
}

struct EditorMenuItemGrid: View {
    
    let style: EditingStyleEnum
    let isCurrentlySelected: Bool
    let onGridPressed: () -> ()
    
    var body: some View {
        
        VStack(spacing: 5) {
            
            ZStack {
                
                Circle()
                    .fill(isCurrentlySelected ? Color.button.primary : Color.button.secondary)
                
                Image(systemName: style.imageName)
                    .font(.system(size: 28, weight: .medium))
                    .imageScale(.medium)
                    .padding()
                    .foregroundStyle(isCurrentlySelected ? Color.text.black : Color.text.white)
            }
            
            Text(style.titleName)
                .font(.custom(.fonts.poppinsMedium, size: 14))
                .foregroundStyle(Color.text.white)
        }
        .onTapGesture {
            onGridPressed()
        }
    }
}

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
