//  
//  TabBarView.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 25/10/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct TabBarView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                
                HStack {
                    
                    CircularTabBarButton(imageName: "book", backgroundColor: .background.thirtiary) {
                        viewModel.showTabBarModal = .history
                    }
                    .frame(width: geo.size.height * 0.09, height: geo.size.height * 0.09)
                    
                    Spacer()
                    
                    CircularTabBarButton(imageName: "gearshape", backgroundColor: .button.secondary) {
                        viewModel.showTabBarModal = .settings
                    }
                    .frame(width: geo.size.height * 0.09, height: geo.size.height * 0.09)
                    
                }
                .padding(5)
                .background(Capsule().fill(.thinMaterial))
                .environment(\.colorScheme, .light)
                .frame(maxWidth: geo.size.width * 0.4, maxHeight: geo.size.height * 0.1)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .preferredColorScheme(.light)
            .padding(.bottom, 5)
        }
    }
}

#Preview {
    TabBarView()
        .previewLayout(.sizeThatFits)
}

