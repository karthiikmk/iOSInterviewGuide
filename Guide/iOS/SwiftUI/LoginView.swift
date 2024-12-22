//
//  LoginView.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 21/12/24.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    
    init() { }
    
    func login() {
        // Implement login functionality using username and password
        print("Logging in with username: \(username) and password: \(password)")
    }
}

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Username", text: $viewModel.username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: viewModel.login) {
                    Text("Log In")
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 44)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(22)
                }
                .padding()
            }
            .navigationTitle("Login")
        }
    }
}

#Preview {
    LoginView()
}
