//
//  CheckBoxView.swift
//  EventManage
//

import SwiftUI

struct CheckBoxView: View {
    var title: String
    @Binding var isChecked: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                self.isChecked.toggle()
            }) {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .foregroundColor(isChecked ? .blue : .gray)
            }
            .padding(.trailing, 10)
            
            Text(title)
                .foregroundColor(.white)
            
            Spacer()
        }
        .padding(.top, 20)
    }
}
