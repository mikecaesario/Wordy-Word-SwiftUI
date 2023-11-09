//  
//  EditHistoryView.swift
//  Wordy Word (SwiftUI)
//
//  Created with ❤️‍🔥 by Michael Caesario on 08/11/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import SwiftUI

struct EditHistoryView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let editHistoryItem: EditHistoryItem
    
    var body: some View {
        
        ZStack {
            
            ScrollView(.vertical, showsIndicators: true) {
                
                LazyVStack(spacing: 20) {
                    
                    Text("Original")
                        .historyHeaderStyle()
                    
                    NavigationLink {
                        
                        DetailedOriginalTextView(originalText: editHistoryItem.uneditedItem)
                    } label: {
                        
                        Text(editHistoryItem.uneditedItem)
                            .font(.custom(.fonts.poppinsMedium, size: 22))
                            .foregroundStyle(Color.text.white)
                            .multilineTextAlignment(.leading)
                            .lineLimit(10)
                    }
                    
                    Text(editHistoryItem.result.count > 1 ? "Edits" : "Edit")
                        .historyHeaderStyle()

                    ForEach(editHistoryItem.result, id: \.timeStamp) { result in
                        
                        NavigationLink {
                            DetailedHistoryResultView(detailedHistory: result)
                        } label: {
                            EditedItemCell(editHistoryItemResult: result)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 105)
            }
            
            EditHistoryNavigationBar(symbolName: "chevron.left") {
                dismiss()
            }
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.primary)
    }
}

#Preview {
    
    let data = MockViewModel.previewData[0].items[0]
    return EditHistoryView(editHistoryItem: data)
}

struct EditedItemCell: View {
    
    let editHistoryItemResult: EditHistoryItemResults
    
    @State private var viewSize: CGSize = .zero
    
    var body: some View {
        
        VStack(spacing: 5) {
            
            Text(editHistoryItemResult.result)
                .font(.custom(.fonts.poppinsMedium, size: 16))
                .foregroundStyle(Color.text.white)
                .lineLimit(5)
                .multilineTextAlignment(.leading)
            
            HStack {
                
                Text(DateFormatter.formattedHourFromDate.string(from: editHistoryItemResult.timeStamp))
                    .font(.custom(.fonts.poppinsMedium, size: 12))
                    .foregroundStyle(Color.text.grey)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)

                Spacer()
                
                Text(editHistoryItemResult.style)
                    .font(.custom(.fonts.poppinsMedium, size: 12))
                    .foregroundStyle(Color.text.grey)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)

            }
        }
        .padding()
        .getViewSize($viewSize)
        .background(
            RoundedRectangle(cornerRadius: viewSize.width / 15)
                .foregroundStyle(Color.background.thirtiary)
        )
    }
}

struct EditHistoryNavigationBar: View {
    
    let symbolName: String
    let onButtonPress: () -> ()
    
    @State private var viewSize: CGSize = .zero
    
    var body: some View {
        
        ZStack {
            
            Button {
                onButtonPress()
            } label: {
                NavigationBarCircleButton(symbolName: symbolName)
            }
            .frame(maxWidth: viewSize.height * 0.55, maxHeight: viewSize.height * 0.55)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 18)
        }
        .frame(height: 100)
        .getViewSize($viewSize)
        .background(
            LinearGradient(stops: [Gradient.Stop(color: .clear, location: 1.0), Gradient.Stop(color: .background.primary, location: 0.6)], startPoint: .top, endPoint: .bottom)
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct NavigationBarCircleButton: View {
    
    let symbolName: String
    
    var body: some View {
        
        ZStack {
            
            Circle()
                .fill(Color.background.thirtiary)
            
            Image(systemName: symbolName)
                .font(.system(size: 20, weight: .light))
                .imageScale(.small)
                .foregroundStyle(Color.text.white)
                .padding()
        }
    }
}
