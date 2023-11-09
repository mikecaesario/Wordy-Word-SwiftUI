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
    
    @State private var viewSize: CGSize = .zero
    let screenSize = UIScreen.main.bounds
    
    var body: some View {
        
        ZStack {
            
            HStack(alignment: .center) {
                
                CircularTabBarButton(imageName: "book", backgroundColor: .background.thirtiary, paddingAlignment: .leading) {
                    viewModel.showTabBarModal = .history
                }
                
                Spacer()

                CircularTabBarButton(imageName: "gearshape", backgroundColor: .button.secondary, paddingAlignment: .trailing) {
                    viewModel.showTabBarModal = .settings
                }
                
            }
            .frame(maxWidth: screenSize.width * 0.45, maxHeight: screenSize.height * 0.1)
            .background(.ultraThinMaterial)
            .clipShape(Capsule())
            .preferredColorScheme(.light)
            .getViewSize($viewSize)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
}

#Preview {
    TabBarView()
        .previewLayout(.sizeThatFits)
}

