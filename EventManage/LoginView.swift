//
//  LoginView.swift
//  EventManage
//

import SwiftUI
import AlertToast

struct LoginView: View {
    @State private var loginName: String = ""
    @State private var loginType: String = ""
    @State private var loginID: String = ""
    @State private var password: String = ""
    @State private var isLoggedin = false
    @State private var showToast = false
    @State private var isWaiting = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                // CardView
                VStack {
                    VStack {
                        Image("Icon")
                            .resizable()
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .frame(width: 104, height: 104)
                            .padding(.bottom, 10)
                        
                        Text("EventManage")
                            .padding(.bottom, 20)
                        
                        TextField("Login ID", text: $loginID)
                            .background(Color.white)
                            .foregroundColor(.black)
                        
                        Divider()
                            .frame(height: 1)
                            .padding(.horizontal, 30)
                            .background(Color.black)
                        
                        Spacer()
                            .frame(height: 30)
                        
                        SecureField("Password", text: $password)
                            .background(Color.white)
                            .foregroundColor(.black)
                        
                        Divider()
                            .frame(height: 1)
                            .padding(.horizontal, 30)
                            .background(Color.black)
                        
                        Spacer()
                            .frame(height: 40)
                        
                        Button(action: {
                            performLogin()
                        }) {
                            Text("Log In")
                                .frame(width: 216, height: 47)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding(20)
                }
            }.toast(isPresenting: $showToast, duration: 1, tapToDismiss: true, alert: {
                AlertToast(displayMode: .banner(.slide), type: .regular, title: "Error: \(errorMessage)")
            }, onTap: {
            }, completion: {
            })
        }
        .navigate(to: DashView(name: loginName, post: loginType, loginID: loginID), when: $isLoggedin)
        .waiting(isWaiting)
    }
    
    private func performLogin() {
        isWaiting = true
        
        guard let url = URL(string: API.LOGIN) else {
            errorMessage = "Invalid URL"
            showToast = true
            isWaiting = false
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "email=\(loginID)&pass=\(password)".data(using: .utf8)
        
        password = ""
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error performing request: \(error)")
                errorMessage = error.localizedDescription
                showToast = true
                return
            }
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(LoginResponse.self, from: data)
                    if response.code == 200 {
                        loginName = response.name
                        loginType = response.type
                        isLoggedin = true
                    } else {
                        errorMessage = response.message
                        showToast = true
                    }
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
    LoginView()
}
