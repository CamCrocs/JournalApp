//
//  AuthModel.swift
//  Journal
//
//  Created by Cameron Crockett on 11/16/24.
//

import Foundation
import FirebaseAuth

class AuthModel: ObservableObject {
    
    @Published var isUserAuthenticated = false
    @Published var errorMessage: String?
    
    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            } else {
                self?.sendEmailVerification()
            }
        }
    }
    
    func signInUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            } else {
                if let user = Auth.auth().currentUser, user.isEmailVerified {
                    self?.isUserAuthenticated = true
                    print("User signed in and verified: \(self?.isUserAuthenticated ?? false)")
                } else {
                    self?.errorMessage = "Please verify your email before signing in."
                }
            }
        }
    }
    
    func sendEmailVerification() {
        if let user = Auth.auth().currentUser {
            user.sendEmailVerification { [weak self] error in
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.errorMessage = "Verification email sent. Please check your inbox."
                }
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            isUserAuthenticated = false
        } catch let signOutError {
            errorMessage = signOutError.localizedDescription
        }
    }
}
