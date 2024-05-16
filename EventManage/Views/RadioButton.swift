//
//  RadioButton.swift
//  EventManage
//

import SwiftUI

struct RadioButton: View {
    var title: String
    @Binding var isSelected: String
    
    var body: some View {
        Button(action: {
            isSelected = title
        }) {
            HStack {
                Image(systemName: isSelected == title ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(isSelected == title ? .blue : .gray)
                Text(title)
                    .foregroundColor(.white)
            }
            .padding(.trailing, 20)
        }
    }
}
