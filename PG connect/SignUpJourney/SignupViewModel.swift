// SignUpViewModel.swift

// SignUpViewModel.swift

import SwiftUI

class SignUpViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var phone = ""
    @Published var state = ""
    @Published var city = ""
    @Published var password = ""
    @Published var confirmPass = ""
    @Published var errorMessage = ""
    @Published var signUpPressed = false
    @Published var selectedGenderIndex = 0
    @Published var genderOptions = ["","Male", "Female", "Other"]
    @Published var isLoggedIn = false
    
    var gender: String {
        return genderOptions[selectedGenderIndex]
    }
    
   
    func signUp() async throws {
        do {
            try await AuthService.shared.signUp(withName: name, email: email, phone: phone, state: state, city: city, password: password, gender: gender) { result in
                switch result {
                case .success(let token):
                    print("Sign-up successful")
                    self.handleSuccessfulSignUp(withToken: token)
                case .failure(let error):
                    print("Error signing up: \(error.localizedDescription)")
                    self.errorMessage = error.localizedDescription
                }
            }
        }
        catch {
            self.errorMessage = error.localizedDescription
            
        }
    }
    func handleSuccessfulSignUp(withToken token: String) {
        // Handle successful sign-in here, such as navigating to the next screen
        print("Yeah Boi")
        AuthService.shared.saveToken(token)
        self.isLoggedIn = true
    }
}

