//
//  DashView.swift
//  EventManage
//

import SwiftUI

struct DashView: View {
    @State var name: String
    @State var post: String
    @State var loginID: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        // Welcome Text
                        Text("Welcome \(name)!, Our \(post)")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 20)
                        
                        Spacer()
                            .frame(height: 30)
                        
                        // Buttons
                        VStack(spacing: 20) {
                            if(post == "Campaigner"){
                                NavigationLink {
                                    RegistrationView()
                                } label: {
                                    Text("Register For Event")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .frame(width: 212, height: 50)
                                        .background(Color.blue)
                                        .cornerRadius(8)
                                }
                                NavigationLink {
                                    EventRegView()
                                } label: {
                                    Text("Event Participation")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .frame(width: 212, height: 50)
                                        .background(Color.blue)
                                        .cornerRadius(8)
                                }
                            } else if(post == "Coordinator") {
                                NavigationLink {
                                    QRScannerView(adminMail: loginID)
                                } label: {
                                    Text("Take Attendence")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .frame(width: 212, height: 50)
                                        .background(Color.blue)
                                        .cornerRadius(8)
                                }
                            }
                            NavigationLink {
                                ParticipantListView()
                            } label: {
                                Text("List of Participants")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .frame(width: 212, height: 50)
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("Logout")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .frame(width: 212, height: 50)
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.bottom, 20)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    DashView(name: "Dhruv Shah", post: "Campaigner", loginID: "Dhruv@gmail.com")
}
