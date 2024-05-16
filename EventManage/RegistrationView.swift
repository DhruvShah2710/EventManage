//
//  RegistrationView.swift
//  EventManage
//

import SwiftUI
import AlertToast

struct RegistrationView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var mobileNumber = ""
    @State private var collegeName = ""
    @State private var semester = 6
    @State private var gender = "Male"
    @State private var selectedDept = "Computer"
    
    @State private var showToast = false
    @State private var isWaiting = false
    @State private var errorMessage = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 20) {
                        Text("Register Participant")
                            .foregroundColor(.white)
                        
                        // TextFields
                        TextField("First Name", text: $firstName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.black)
                            .padding(.horizontal, 20)
                        
                        TextField("Last Name", text: $lastName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.black)
                            .padding(.horizontal, 20)
                        
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.black)
                            .padding(.horizontal, 20)
                        
                        TextField("Mobile Number", text: $mobileNumber)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.black)
                            .padding(.horizontal, 20)
                        
                        TextField("College Name", text: $collegeName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.black)
                            .padding(.horizontal, 20)
                        
                        // Gender RadioButtons
                        HStack {
                            RadioButton(title: "Male", isSelected: $gender)
                            RadioButton(title: "Female", isSelected: $gender)
                            RadioButton(title: "Other", isSelected: $gender)
                        }
                        .padding(.top, 10)
                        .padding(.horizontal, 20)
                        
                        Picker("Semester", selection: $semester) {
                            ForEach(1..<9) {
                                Text("Semester \($0)").tag($0)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 300, height: 45)
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.top, 10)
                        .foregroundColor(.black)
                        
                        // Department Spinner
                        DeptSpinnerView(selectedDept: $selectedDept)
                        
                        // Submit Button
                        Button(action: {
                            performRegister()
                        }) {
                            Text("Submit")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: 200, height: 50)
                                .background(Color.blue)
                                .cornerRadius(8)
                                .padding(.bottom, 30)
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
    
    private func performRegister() {
        isWaiting = true
        
        guard let url = URL(string: API.REGISTER) else {
            errorMessage = "Invalid URL"
            showToast = true
            isWaiting = false
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "email=\(email)&fname=\(firstName)&lname=\(lastName)&college=\(collegeName)&department=\(selectedDept)&semester=\(semester)&mobile=\(mobileNumber)&gender=\(gender)".data(using: .utf8)
        print(String(data: request.httpBody!, encoding: .utf8) ?? "")
        
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
    RegistrationView()
}
