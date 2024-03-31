//
//  AuthService.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 29/03/24.
//

import Foundation
import SwiftUI

class AuthService: ObservableObject {
    
    static let shared = AuthService()
    @Published var isLoggedIn: Bool = false
    @Published var pgData: [PGData] = []
    
    
    func signIn(withEmail email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        // Check if email and password are not empty
        guard !email.isEmpty && !password.isEmpty else {
            let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Error: Please enter both email and password"])
            completion(.failure(error))
            return
        }
        
        // Prepare your API request
        let url = URL(string: "https://production.pgplanner.in/api/login/user")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Prepare request body
        let requestBody: [String: Any] = ["email": email, "password": password]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Error: Failed to serialize request body"])
            completion(.failure(error))
            return
        }
        request.httpBody = jsonData
        
        // Make the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response
            if let data = data {
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response Data:", responseString)
                }
                // Parse response data
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    // Authentication successful
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let user = json["user"] as? [String: Any],
                       let token = user["token"] as? String {
                        print("Login successful")
                        print("Token:", token)
                        completion(.success(token))
                        // Upload device token
                        self.uploadDeviceToken(token: token)
                        
                    } else {
                        // Failed to parse token from response
                        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Error: Failed to parse token from response"])
                        print(error.localizedDescription)
                        completion(.failure(error))
                    }
                } else {
                    // Authentication failed
                    // Parse error message from response
                    if let errorMessage = String(data: data, encoding: .utf8) {
                        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                        print(errorMessage)
                        completion(.failure(error))
                    } else {
                        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Error: Unable to parse error message"])
                        print(error.localizedDescription)
                        completion(.failure(error))
                    }
                }
            } else if let error = error {
                // Handle error
                print("Error:", error.localizedDescription)
                completion(.failure(error))
            }
        }.resume()
    }
    
    @MainActor
    func signUp(withName name: String, email: String, phone: String, state: String, city: String, password: String, gender: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        // Implement the sign-up API request here
        guard !name.isEmpty && !email.isEmpty && !phone.isEmpty && !state.isEmpty && !city.isEmpty && !password.isEmpty && !gender.isEmpty else {
            let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Error: Please fill in all required fields"])
            completion(.failure(error))
            return
        }
        
        // Example implementation:
        let url = URL(string: "https://production.pgplanner.in/api/signup/user")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = [
            "name": name,
            "email": email,
            "phone": phone,
            "state": state,
            "city": city,
            "password": password,
            "gender": gender
        ]
        print("Request Body:", requestBody)
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Error: Failed to serialize request body"])
            completion(.failure(error))
            return
        }
        request.httpBody = jsonData
        
        // Make the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response
            if let data = data {
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response Data:", responseString)
                }
                // Parse response data
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    // Authentication successful
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let user = json["user"] as? [String: Any],
                       let token = user["token"] as? String {
                        print("Login successful")
                        print("Token:", token)
                        completion(.success(token))
                        // Upload device token
                        self.uploadDeviceToken(token: token)
                    } else {
                        // Failed to parse token from response
                        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Error: Failed to parse token from response"])
                        print(error.localizedDescription)
                        completion(.failure(error))
                    }
                } else {
                    // Authentication failed
                    // Parse error message from response
                    if let errorMessage = String(data: data, encoding: .utf8) {
                        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                        print(errorMessage)
                        completion(.failure(error))
                    } else {
                        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Error: Unable to parse error message"])
                        print(error.localizedDescription)
                        completion(.failure(error))
                    }
                }
            } else if let error = error {
                // Handle error
                print("Error:", error.localizedDescription)
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchPGData() {
        guard let url = URL(string: "https://production.pgplanner.in/api/user/getpgsforuser") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Fetch bearer token from AuthService
        if let bearerToken = AuthService.shared.getToken() {
            request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        } else {
            print("Bearer token not available")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            

            do {
                let decodedData = try JSONDecoder().decode(PgResponse.self, from: data)
                DispatchQueue.main.async {
                    self.pgData = decodedData.pgdata
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }

        }.resume()
    }



    // Function to retrieve device token
    func getDeviceToken() -> String? {
        guard let deviceToken = UIDevice.current.identifierForVendor?.uuidString else {
            return nil
        }
        return deviceToken
    }
    func uploadDeviceToken(token: String) {
        // Prepare your API request
        let url = URL(string: "https://production.pgplanner.in/api/login/userdevicetoken")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // Add authorization header with bearer token
        let bearerToken = "Bearer \(token)"
        print("Bearer Token:", bearerToken)
        request.addValue(bearerToken, forHTTPHeaderField: "Authorization")
        
        // Prepare request body
        let requestBody = "devicetoken=\(getDeviceToken() ?? "")"
        print("Device Token:", requestBody)
        request.httpBody = requestBody.data(using: .utf8)
        
        // Make the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    print("Device token uploaded successfully")
                } else {
                    print("Failed to upload device token. Status code: \(httpResponse.statusCode)")
                }
            } else if let error = error {
                print("Error uploading device token: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func saveToken(_ token: String) {
        // Save token securely, e.g., using Keychain or UserDefaults
        UserDefaults.standard.set(token, forKey: "userToken")
    }
    
    func getToken() -> String? {
        // Retrieve token securely
        return UserDefaults.standard.string(forKey: "userToken")
        print("$$$$\(UserDefaults.standard.string(forKey: "userToken"))")
    }
    func clearToken() {
        // Clear token from storage
        UserDefaults.standard.removeObject(forKey: "userToken")
        // Optionally perform any other cleanup tasks
        isLoggedIn = false
    }
}
