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
    @Published var ProfileData: UserProfileResponse?
    @Published var pgData2: PGDetailsData?
    @Published var rentTableResponse: RentTableResponse?
    @Published var walletResponse: WalletResponse?
    
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
    
    func getPGDetailsForUser(_ id: String,completion: @escaping (Result<PGDetailsResponse, Error>) -> Void) {
        let token = AuthService.shared.getToken()
        // Prepare your API request
        let bearerToken = "Bearer \(token)"
        //let s = "6599614a01a55c3f8471edff"
        let urlString = "https://production.pgplanner.in/api/user/getpgdetailsforuser/\(id)"
        guard let url = URL(string: urlString)  else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // Fetch bearer token from AuthService
        if let bearerToken = AuthService.shared.getToken() {
            request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        } else {
            completion(.failure(NSError(domain: "Bearer token not available", code: -1, userInfo: nil)))
            return
        }
        // Make the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "Unknown error", code: -1, userInfo: nil)))
                return
            }
            
            do {
                // Parse JSON response
                let pgDetails = try JSONDecoder().decode(PGDetailsResponse.self, from: data)
                completion(.success(pgDetails))
                //print("API Response:", pgDetails)
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    func fetchUserData() {
        guard let url = URL(string: "https://production.pgplanner.in/api/user/profile") else {
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
            guard let data = data else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    // Response is successful, parse the JSON data
                    do {
                        let userProfile = try JSONDecoder().decode(UserProfileResponse.self, from: data)
                        // Update the ProfileData property with the parsed user profile data
                        DispatchQueue.main.async {
                            self.ProfileData = userProfile
                        }
                        
                        //print("API Response:", userProfile)
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                } else {
                    // Handle other status codes if needed
                    print("Error: Status Code \(httpResponse.statusCode)")
                }
            }
        }.resume()
    }
    
    static func UploadUserData(userProfile: UserProfile2, completion: @escaping (Result<Data?, Error>) -> Void) {
        let url = URL(string: "https://production.pgplanner.in/api/user/changeprofile")!
        
        guard let jsonData = try? JSONEncoder().encode(userProfile) else {
            completion(.failure(NetworkError.encodingError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Fetch bearer token from AuthService
        if let bearerToken = AuthService.shared.getToken() {
            request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        } else {
            print("Bearer token not available")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
                // Handle response based on status code
            }
            
            if let data = data {
                print("Response data: \(String(data: data, encoding: .utf8) ?? "")")
            }
            
            completion(.success(data))
        }.resume()
    }
    func uploadImageToBackend(image: UIImage, completion: @escaping (Bool) -> Void) {
        // Convert UIImage to Data
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Failed to convert image to data.")
            completion(false)
            return
        }
        
        // Prepare URL Request
        guard let url = URL(string: "https://production.pgplanner.in/api/pgowner/changeprofileimage") else {
            print("Invalid URL")
            completion(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        // Fetch bearer token from AuthService
        if let bearerToken = AuthService.shared.getToken() {
            request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        } else {
            print("Bearer token not available")
            return
        }
        
        // Prepare FormData
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var body = Data()
        
        // Append image data
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"profileimage\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        
        // End boundary
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        
        request.httpBody = body
        
        // Create URLSessionDataTask
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response
            if let error = error {
                print("Error: \(error)")
                completion(false)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Status code: \(response.statusCode)")
                // Handle status code
                if response.statusCode == 200 {
                    completion(true)
                } else if response.statusCode == 413 {
                    DispatchQueue.main.async {
                        // Show alert for payload too large
                        let alertController = UIAlertController(title: "Error", message: "Failed to upload image. Payload too large.", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                    }
                    completion(false)
                } else {
                    completion(false)
                }
            }
        }.resume()
    }
    
    func fetchRentTable() {
        guard let url = URL(string: "https://production.pgplanner.in/api/user/getrenttableofuser") else {
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
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            print("Status code: \(httpResponse.statusCode)")
            
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(RentTableResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.rentTableResponse = decodedData
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
    
    func fetchWalletData() {
        guard let url = URL(string: "https://production.pgplanner.in/api/user/getwalletofuser") else {
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
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            print("Status code: \(httpResponse.statusCode)")
            
            if let data = data {
                do {
                    
                    let jsonString = String(data: data, encoding: .utf8) ?? "Data could not be printed"
                    print("JSON Response: \(jsonString)")
                    
                    let decodedData = try JSONDecoder().decode(WalletResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.walletResponse = decodedData
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
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
    enum NetworkError: Error {
        case encodingError
    }
}
