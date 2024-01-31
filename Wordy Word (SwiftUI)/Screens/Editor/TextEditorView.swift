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
        
    @StateObject private var viewModel: AppViewModel
    
    @FocusState private var isFocused: whichTextfieldOrTextEditorIsFocused?
    @State private var currentModalPresentationDetent: PresentationDetent = .medium
    
    init(historyDataManager: HistoryDataManagerProtocol, textEditorManager: TextEditorManagerProtocol) {

        _viewModel = StateObject(wrappedValue: AppViewModel(historyDataManager: historyDataManager, textEditorManager: textEditorManager))
    }
    
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 10) {
                              
                        if viewModel.showRemoveButtonStack {
                            
                            RemoveButtonStackView()
                                .transition(.fadeAndMoveDown)
                        }
                        
                        if viewModel.showReplaceTextfield {
                            
                            ReplaceTextfieldStackView(isFocused: $isFocused)
                                .padding(.horizontal, 18)
                                .transition(.fadeAndMoveUp)
                        }
                        
                        TextEditorCapsuleView(isFocused: $isFocused)
                            .frame(height: geo.size.height * 0.5)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 18)

                        
                        if viewModel.showResultView {
                            
                            TextResultCapsuleView()
                                .frame(height: geo.size.height * 0.5)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 18)
                                .transition(.fadeAndMoveUp)
                        }

                    }
                    .padding(.top, 75)
                    .padding(.bottom, geo.size.height * 0.15)
                    .animation(.linear(duration: 0.4), value: viewModel.showRemoveButtonStack)
                    .animation(.linear(duration: 0.4), value: viewModel.showReplaceTextfield)
                    .animation(.linear(duration: 0.4), value: viewModel.showResultView)

                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 0.1) // Tell the scrollView to respect the top safe area
                
                EditorNavigationBarView() {
                    isFocused = nil
                }
                
                TabBarView()
                
                editorStylePicker
                
            }
            .toastView(viewModel.showToast, withType: viewModel.toastType)
            .onTapGesture {
                isFocused = nil
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background.primary.ignoresSafeArea())
            .preferredColorScheme(.dark)
            .sheet(item: $viewModel.showTabBarModal) { modal in
                
                switch modal {
                case .history:
                    
                    HistoryView(currentModalPresentationDetent: $currentModalPresentationDetent, historyData: viewModel.historyDataArray)
                        .presentationDetents([.medium, .large], selection: $currentModalPresentationDetent)
                        .presentationBackgroundInteraction(.disabled)
                        .presentationCornerRadius(40)
                        .presentationDragIndicator(.hidden)
                        .presentationContentInteraction(.resizes)
                case .settings:
                    
                    SettingsView()
                        .presentationDetents([.medium])
                        .presentationBackgroundInteraction(.disabled)
                        .presentationCornerRadius(40)
                }
            }
            .environmentObject(viewModel)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    
    return TextEditorView(historyDataManager: HistoryDataManager(), textEditorManager: TextEditorManager())
}


extension TextEditorView {
    
    private var editorStylePicker: some View {
        
        ZStack {
            
            if viewModel.showEditorStylePicker {

                EditingStylePickerView()
                    .transition(.opacity)
            }
        }
    }
}

struct ToastView: View {
        
    let type: ToastType
    
    @State private var viewSize: CGSize = .zero
    
    var body: some View {
        
        ZStack {
            
            HStack(spacing: 10) {
                
                Image(systemName: type.symbol)
                    .aspectRatio(1, contentMode: .fill)
                    .foregroundStyle(Color.text.white.opacity(0.5))
                    .font(.system(size: 35))
                
                Text(type.message)
                    .font(.system(size: 17))
                    .foregroundStyle(Color.text.white)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(minHeight: viewSize.height * 0.12)
            .background(
                Capsule()
                    .fill(Color.blue)
            )
            .padding(.horizontal, 20)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .getViewSize($viewSize)
    }
}

