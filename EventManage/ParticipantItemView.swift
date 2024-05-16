//
//  ParticipantItemView.swift
//  EventManage
//

import SwiftUI

struct ParticipantItemView: View {
    let participant: Participant
    
    var body: some View {
        ZStack {
            Color.clear.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                Text(participant.name)
                    .frame(maxWidth: .infinity)
                    .frame(height: 30)
                    .background(Color.indigo)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold))
                
                Divider()
                
                HStack {
                    Text(participant.phoneNumber)
                        .foregroundColor(Color.black)
                        .padding(.leading, 5)
                        .padding(.top, 10)
                    
                    Spacer()
                    
                    Text("Sem: " + participant.semester)
                        .foregroundColor(Color.black)
                        .padding(.trailing, 5)
                        .padding(.top, 10)
                }
                
                HStack {
                    Text(participant.email)
                        .foregroundColor(Color.black)
                        .padding(.leading, 5)
                        .padding(.top, 10)
                    
                    Spacer()
                    
                    Text(participant.college)
                        .foregroundColor(Color.black)
                        .padding(.trailing, 5)
                        .padding(.top, 10)
                }
                
                Spacer()
                    .frame(height: 10)
                
                Divider()
                
                Text(participant.eventName)
                    .frame(maxWidth: .infinity)
                    .frame(height: 30)
                    .background(Color.indigo)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold))
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(10)
        }
    }
}

#Preview {
    ParticipantItemView(participant: Participant(id: 0, name: "Ravi", phoneNumber: "+919999999999", semester: "6", email: "patel@gmail.com", college: "CKPCET", eventName: "C-Quest"))
}
