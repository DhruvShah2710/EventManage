//
//  QRScannerView.swift
//  EventManage
//

import SwiftUI
import AlertToast
import CodeScanner

struct QRScannerView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var adminMail:String
    @State private var pname = ""
    @State private var pevent = ""
    @State private var pemail = ""
    @State private var isPresentingScanner = true
    @State private var isAttended = false
    @State private var scannedCode: String?
    @State private var showDetail = false
    @State private var isWaiting = false
    @State private var errorMessage = "Failed to Mark Attendance!"
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 10) {
                    if isAttended {
                        Image("approved")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 265)
                            .padding()
                            .animation(.easeIn)
                            .offset(y: showDetail ? 0 : -500) // Slide down animation
                        
                        DetailsCardView(name: $pname, event: $pevent, email: $pemail)
                    } else {
                        Text(errorMessage)
                            .foregroundColor(.white)
                    }
                }
                .sheet(isPresented: $isPresentingScanner) {
                    CodeScannerView(codeTypes: [.qr]) { response in
                        if case let .success(result) = response {
                            scannedCode = result.string
                            isPresentingScanner = false
                            performAttendance()
                        }
                    }
                }
            }
        }.waiting(isWaiting)
    }
    
    private func performAttendance() {
        isWaiting = true
        
        guard let url = URL(string: API.ATTEND) else {
            errorMessage = "Invalid URL"
            isWaiting = false
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "email=\(adminMail)&eventcode=\(scannedCode ?? "")".data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error performing request: \(error)")
                errorMessage = error.localizedDescription
                return
            }
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(AttendResponse.self, from: data)
                    if response.code == 200 {
                        pname = response.name
                        pevent = response.event
                        pemail = response.email
                        isAttended = true
                        withAnimation {
                            showDetail = true
                        }
                    } else {
                        errorMessage = response.message
                    }
                } catch {
                    print("Error decoding response: \(error)")
                    errorMessage = "Failed to decode response"
                }
            } else {
                print("No data received")
                errorMessage = "No data received from server"
            }
            
            DispatchQueue.main.async {
                isWaiting = false // Hide waiting dialog
            }
        }.resume()
    }
}

#Preview {
    QRScannerView(adminMail: "Dhruv@gmail.com")
}
