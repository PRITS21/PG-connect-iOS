//
//  SigninViewModel.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 29/03/24.
//

import SwiftUI

class SigninViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var showAlert = false
    @Published var isLoggedIn = false // Added property to track login status

    
    func signIn() async throws {
        do {
            try await AuthService.shared.signIn(withEmail: email, password: password) { result in
                switch result {
                case .success(let token):
                    DispatchQueue.main.async {
                        self.errorMessage = ""
                        self.handleSuccessfulSignIn(withToken: token)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                        self.showAlert = true
                    }
                }
            }
        } catch {
            self.errorMessage = error.localizedDescription
            self.showAlert = true
        }
    }

    
    func handleSuccessfulSignIn(withToken token: String) {
        // Handle successful sign-in here, such as navigating to the next screen
        print("Hola yeah")
        AuthService.shared.saveToken(token)
        self.isLoggedIn = true

    }
}
