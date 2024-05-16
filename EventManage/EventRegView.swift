//
//  EventRegView.swift
//  EventManage
//

import SwiftUI
import AlertToast

struct EventRegView: View {
    @State private var selectedDept = Department.computer
    @State private var selectedEvent = Event.placementDrive
    @State private var email = ""
    
    @State private var showToast = false
    @State private var isWaiting = false
    @State private var errorMessage = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            ZStack {
                // Background Image
                Image("background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 20) {
                        Text("Participate in Event")
                            .foregroundColor(.white)
                        
                        // Email TextFields
                        TextField("Participant Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.black)
                            .padding(.horizontal, 20)
                        
                        // Department Event Spinner
                        DeptEventSpinnerView(selectedDept: $selectedDept, selectedEvent: $selectedEvent)
                        
                        // Submit Button
                        Button(action: {
                            performEventRegister()
                        }) {
                            Text("Submit")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: 200, height: 50)
                                .background(Color.blue)
                                .cornerRadius(8)
                                .padding(.bottom, 65)
                        }
                    }
                    .padding(.top, 20)
                }
            }.toast(isPresenting: $showToast, duration: 1, tapToDismiss: true, alert: {
                AlertToast(displayMode: .banner(.slide), type: .regular, title: errorMessage)
            }, onTap: {
            }, completion: {
            })
        }
        .waiting(isWaiting)
    }
    
    private func performEventRegister() {
        isWaiting = true
        
        guard let url = URL(string: API.EVENTREGISTER) else {
            errorMessage = "Invalid URL"
            showToast = true
            isWaiting = false
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "email=\(email)&eventcode=\(selectedEvent.code)".data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error performing request: \(error)")
                errorMessage = error.localizedDescription
                showToast = true
                return
            }
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(RegResponse.self, from: data)
                    errorMessage = response.message
                    showToast = true
                } catch {
                    print("Error decoding response: \(error)")
                    errorMessage = "Failed to decode response"
                    showToast = true
                }
            } else {
                print("No data received")
                errorMessage = "No data received from server"
                showToast = true
            }
            
            DispatchQueue.main.async {
                isWaiting = false // Hide waiting dialog
            }
        }.resume()
    }
}

#Preview {
    EventRegView()
}
