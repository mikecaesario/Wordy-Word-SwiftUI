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
    @FocusState private var isFocused: whichTextfieldOrTextEditorIsFocused?
    
    init(historyDataManager: HistoryDataManagerProtocol, textEditorManager: TextEditorManagerProtocol) {
        
//#if DEBUG
        _viewModel = StateObject(wrappedValue: MockViewModel.shared.viewModel)
//#else
//        _viewModel = StateObject(wrappedValue: AppViewModel(historyDataManager: historyDataManager, textEditorManager: textEditorManager))
//#endif
    }
    
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 10) {
                              
                        if viewModel.showRemoveButtonStack {
                            
                            RemoveButtonStackView()
                                .transition(.move(edge: .top))
                                .opacity(viewModel.showRemoveButtonStack ? 1.0 : 0.0)
                        }
                        
                        if viewModel.showReplaceTextfield {
                            
                            ReplaceTextfieldStackView(isFocused: $isFocused)
                                .padding(.horizontal, 18)
                                .transition(.move(edge: .bottom))
                                .opacity(viewModel.showReplaceTextfield ? 1.0 : 0.0)
                        }
                        
                        TextEditorCapsuleView(isFocused: $isFocused)
                            .frame(height: geo.size.height * 0.5)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 18)

                        
                        TextResultCapsuleView()
                            .frame(height: geo.size.height * 0.5)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 18)

                    }
                    .padding(.top, 75)
                    .padding(.bottom, sceenSize.width * 0.25)
                    .animation(.easeIn(duration: 0.3), value: viewModel.showRemoveButtonStack)
                    .animation(.easeIn(duration: 0.3), value: viewModel.showReplaceTextfield)
                    .animation(.easeIn(duration: 0.3), value: viewModel.showResultView)

                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 0.1) // Tell the scrollView to respect the top safe area
                
                EditorNavigationBarView() {
                    isFocused = nil
                }
                
                TabBarView()
                
                editorStylePicker
                
            }
            .onTapGesture {
                isFocused = nil
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background.primary.ignoresSafeArea())
            .getViewSize($sceenSize)
            .preferredColorScheme(.dark)
            .sheet(item: $viewModel.showTabBarModal) { modal in
                
                switch modal {
                case .history:
                    
                    HistoryView(historyData: viewModel.historyData)
                        .presentationDetents([.medium, .large])
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
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    
    return TextEditorView(historyDataManager: HistoryDataManager(), textEditorManager: TextEditorManager())
}


extension TextEditorView {
    
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



