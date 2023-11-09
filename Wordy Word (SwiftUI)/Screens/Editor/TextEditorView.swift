//  
//  ContentView.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 23/10/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct TextEditorView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject private var viewModel: AppViewModel
    
    @State private var sceenSize: CGSize = .zero
    
    init(historyDataManager: HistoryDataManagerProtocol, textEditorManager: TextEditorManagerProtocol) {
        
        _viewModel = StateObject(wrappedValue: AppViewModel(historyDataManager: historyDataManager, textEditorManager: textEditorManager))
    }
    
    var body: some View {
        
        ZStack {
                        
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 10) {
                    
                    removeButtonStack

                    replaceTextfieldStack
                    
                    TextEditorCapsuleView()
                        .frame(maxWidth: .infinity, minHeight: sceenSize.height * 0.45)
                    
                    TextResultCapsuleView()
                        .frame(maxWidth: .infinity, minHeight: sceenSize.height * 0.45)
                }
                .padding(.top, 55)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding([.leading, .trailing, .bottom], 18)
            .ignoresSafeArea(edges: .bottom)

            
            EditorNavigationBarView()

            TabBarView()
            
            editorStylePicker
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.primary.ignoresSafeArea(.all))
        .preferredColorScheme(.dark)
        .getViewSize($sceenSize)
        .sheet(item: $viewModel.showTabBarModal) { modal in
            
            switch modal {
            case .history:
                HistoryView()
//                    .presentationDetents(<#T##detents: Set<PresentationDetent>##Set<PresentationDetent>#>)
//                    .presentationBackgroundInteraction(.disabled)
//                    .presentationCornerRadius(<#T##cornerRadius: CGFloat?##CGFloat?#>)
            case .settings:
                EmptyView()
            }
        }
        .environmentObject(viewModel)
        .onChange(of: scenePhase) { phase in
            
            switch phase {
            case .background:
                break
            case .inactive:
                break
            case .active:
                break
            @unknown default:
                break
            }
        }
    }
}

#Preview {
    
    return TextEditorView(historyDataManager: HistoryDataManager(), textEditorManager: TextEditorManager())
}


extension TextEditorView {
    
    var removeButtonStack: some View {
        
        ZStack {
            
            if viewModel.showRemoveButtonStack {
                
                RemoveButtonStackView()
            }
        }
        .animation(.default, value: viewModel.showRemoveButtonStack)
    }
    
    var replaceTextfieldStack: some View {
        
        ZStack {
            
            if viewModel.showReplaceTextfield {
                
                ReplaceTextfieldStackView()
            }
        }
        .animation(.default, value: viewModel.showReplaceTextfield)
    }
    
    var editorStylePicker: some View {
        
        ZStack{
            
            if viewModel.showEditorStylePicker {
                
                EditingStylePickerView()
                    .transition(.opacity)
            }
        }
        .animation(.default, value: viewModel.showEditorStylePicker)
    }
}
