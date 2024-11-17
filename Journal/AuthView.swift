//
//  AuthView.swift
//  Journal
//
//  Created by Cameron Crockett on 11/16/24.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject private var authModel: AuthModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = false
    @State private var navigateToContentView = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if authModel.errorMessage != nil {
                    Text(authModel.errorMessage!)
                        .foregroundColor(.red)
                        .padding()
                }
                
                Button(action: {
                    if isSignUp {
                        authModel.registerUser(email: email, password: password)
                    } else {
                        signInAndNavigate()
                    }
                }) {
                    Text(isSignUp ? "Sign Up" : "Sign In")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    isSignUp.toggle()
                }) {
                    Text(isSignUp ? "Already have an account? Sign In" : "Don't have an account? Sign Up")
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                NavigationLink(destination: ContentView().environmentObject(authModel), isActive: $navigateToContentView) {
                    EmptyView()
                }
            }
            .padding()
            .navigationTitle(isSignUp ? "Register" : "Sign In")
        }
    }

    private func signInAndNavigate() {
        authModel.signInUser(email: email, password: password)
        if authModel.isUserAuthenticated {
            navigateToContentView = true
        }
    }
}
