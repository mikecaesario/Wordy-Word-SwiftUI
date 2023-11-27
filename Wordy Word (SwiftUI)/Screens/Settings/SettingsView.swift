//  
//  SettingsView.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 09/11/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var viewModel: AppViewModel
    
    private let url: URL = URL(string: "https://www.apple.com")!
    
    var body: some View {
        
        ZStack {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 20) {
                    
                    SavedHistorySettingsCell()
                    
                    Link(destination: url) {
                        GoToDeveloperWebsiteCell()
                    }
                    
                }
                .padding([.horizontal, .bottom])
                .padding(.top, 105)

            }
            
            NavigationTitleView(title: "Settings")
            
        }
        .background(Color.background.primary)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    SettingsView()
        .environmentObject(MockViewModel.shared.viewModel)
}
