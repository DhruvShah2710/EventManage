//
//  DetailsCardView.swift
//  EventManage
//

import SwiftUI

struct DetailsCardView: View {
    @Binding var name: String
    @Binding var event: String
    @Binding var email: String
    
    var body: some View {
        VStack {
            Text(name)
                .font(.system(size: 50, weight: .bold))
                .multilineTextAlignment(.center)
            
            Text(event)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding(.top, 20)
            
            Text(email)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding(.top, 20)
                .padding(.bottom, 10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
