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
    
    init(historyDataManager: HistoryDataManagerProtocol, textEditorManager: TextEditorManagerProtocol) {
        
        _viewModel = StateObject(wrappedValue: AppViewModel(historyDataManager: historyDataManager, textEditorManager: textEditorManager))
    }
    
    var body: some View {
        
        ZStack {
            
            TabBarView()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .environmentObject(viewModel)
        .sheet(item: $viewModel.showTabBarModal) { modal in
            
            switch modal {
            case .history:
                EmptyView()
            case .settings:
                EmptyView()
            }
        }
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
    
    let historyDataManager = HistoryDataManager()
    let textEditorManager = TextEditorManager()
    
    return TextEditorView(historyDataManager: historyDataManager, textEditorManager: textEditorManager)
}
