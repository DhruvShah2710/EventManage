//
//  WaitingView.swift
//  EventManage
//

import SwiftUI

struct WaitingView<Content>: View where Content: View {
    let isWaiting: Bool
    let content: Content
    
    init(isWaiting: Bool, @ViewBuilder content: () -> Content) {
        self.isWaiting = isWaiting
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            content
            if isWaiting {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
                    .foregroundColor(.white)
            }
        }
    }
}
