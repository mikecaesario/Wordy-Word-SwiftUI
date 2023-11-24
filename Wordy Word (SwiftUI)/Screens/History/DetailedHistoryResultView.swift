//  
//  DetailedHistoryView.swift
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

struct DetailedHistoryResultView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let detailedHistory: EditHistoryItemResults
    
    var body: some View {
        
        ZStack {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                Text(detailedHistory.result)
                    .font(.custom(.fonts.poppinsMedium, size: 22))
                    .foregroundStyle(Color.text.white)
                    .multilineTextAlignment(.leading)
                    .textSelection(.enabled)
                    .padding(.horizontal)
                    .padding(.vertical, 105)
            }
            
            DetailedHistoryNavigationBarButtonsView {
                dismiss()
            } onCopyButtonPress: {

            }

            footer
        }
        .navigationBarHidden(true)
        .background(
            Color.background.primary
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    
    let data = MockViewModel.previewData[0].items[0].result[0]
    return DetailedHistoryResultView(detailedHistory: data)
}

extension DetailedHistoryResultView {
    
    var footer: some View {
        
        ZStack {
            
            HStack {
                
                Text(DateFormatter.formattedHourFromDate.string(from: detailedHistory.timeStamp))
                
                Spacer()
                
                Text(detailedHistory.style)
    
            }
            .font(.custom(.fonts.poppinsSemiBold, size: 22))
            .foregroundStyle(Color.text.white)
            
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
        .padding()
        .background(
            LinearGradient(stops: [Gradient.Stop(color: .background.primary, location: 0.6), Gradient.Stop(color: .clear, location: 0.3)], startPoint: .top, endPoint: .bottom)
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
}
struct DetailedHistoryNavigationBarButtonsView: View {
    
    let onBackButtonPress: () -> ()
    let onCopyButtonPress: () -> ()
    
    @State private var viewSize: CGSize = .zero
    
    var body: some View {
        
        ZStack {
            
            HStack {
                
                Button {
                    onBackButtonPress()
                } label: {
                    NavigationBarCircleButton(symbolName: "chevron.left")
                }
                .frame(maxWidth: viewSize.height * 0.55, maxHeight: viewSize.height * 0.55)
                
                Spacer()
                
                Button {
                    onCopyButtonPress()
                } label: {
                    NavigationBarCircleButton(symbolName: "doc.on.doc")
                }
                .frame(maxWidth: viewSize.height * 0.55, maxHeight: viewSize.height * 0.55)
            }
            .padding(.horizontal)
        }
        .frame(height: 100)
        .getViewSize($viewSize)
        .background(
            LinearGradient(stops: [Gradient.Stop(color: .clear, location: 1.0), Gradient.Stop(color: .background.primary, location: 0.6)], startPoint: .top, endPoint: .bottom)
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

