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
    @Published var pgData2: [PGDetailsData] = []
    @Published var rentTableResponse: RentTableResponse?
    @Published var walletResponse: WalletResponse?
    @Published var dndData: [String: [DNDItem]] = [:]
    @Published var noticePeriodData: NoticePeriodData?
    @Published var selectedDate = Date()
    @Published var selectedTime = Date()
    @Published var isLoading = false
    @Published var noticePeriodResponse: String?
    @Published var room: RoomDetailsResponse?
    @Published var skipMenu: [String: [String: Bool]] = [:]
    @Published var expenses: [Expense] = []
    @Published var visitResponse: VisitResponse?
    @Published var bookResponse: BookingResponse?
    @Published var notificationResponse: NotificationResponse?
    @Published var CityResponse: StateAndCity?
    
    //MARK: POST Razor pay
    func createRazorPayOrderForBooking(pgid: String, bookingType: String, roomType: String, sharingType: String, bookingDate: String, bookingTime: String, beds: Int, useWallet: Bool, completion: @escaping (Result<RazorpayOrder, Error>) -> Void) {
        guard let url = URL(string: "https://production.pgplanner.in/api/user/createrazorpayorderforbooking") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let parameters: [String: Any] = [
            "pgid": pgid,
            "bookingtype": bookingType,
            "roomtype": roomType,
            "sharingtype": sharingType,
            "bookingdate": bookingDate,
            "bookingtime": bookingTime,
            "beds": beds,
            "usewallet": useWallet
        ]
        print("Create RazorPay Order for Booking parameters: \(parameters)")
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            completion(.failure(NSError(domain: "Failed to encode parameters", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
                if (200..<300).contains(httpResponse.statusCode) {
                    if let responseData = data {
                        
                        let decoder = JSONDecoder()
                        do {
                            let razorpayOrder = try decoder.decode(RazorpayOrder.self, from: responseData)
                            completion(.success(razorpayOrder)) // Pass back the parsed data
                            return
                        } catch {
                            completion(.failure(error))
                            return
                        }
                    }
                    
                } else {
                    completion(.failure(NSError(domain: "HTTP Error: \(httpResponse.statusCode)", code: httpResponse.statusCode, userInfo: nil)))
                    return
                }
            }
            
            completion(.failure(NSError(domain: "Unknown error", code: 0, userInfo: nil)))
        }.resume()
    }
    
    //MARK: GET Driving License
    func GetDLImage(completion: @escaping (Result<URL, Error>) -> Void) {
        guard let url = URL(string: "https://production.pgplanner.in/api/user/getlicenseimg") else {
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
                    completion(.failure(error))
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let fileURL = documentsURL.appendingPathComponent("image.jpg")
                    do {
                        try data.write(to: fileURL)
                        print("Image data saved to: \(fileURL)")
                        completion(.success(fileURL))
                    } catch {
                        print("Error saving image data: \(error)")
                        completion(.failure(error))
                    }
                } else {
                    // Handle other status codes if needed
                    print("Error: Status Code \(httpResponse.statusCode)")
                }
            }
            
        }.resume()
    }
    
    //MARK: GET Aadhar Card
    func fetchAadhar(completion: @escaping (Result<URL, Error>) -> Void) {
        guard let url = URL(string: "https://production.pgplanner.in/api/user/getaadharimg") else {
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
                    completion(.failure(error))
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let fileURL = documentsURL.appendingPathComponent("image.jpg")
                    do {
                        try data.write(to: fileURL)
                        print("Image data saved to: \(fileURL)")
                        completion(.success(fileURL))
                    } catch {
                        print("Error saving image data: \(error)")
                        completion(.failure(error))
                    }
                } else {
                    // Handle other status codes if needed
                    print("Error: Status Code \(httpResponse.statusCode)")
                    
                }
            }
            
        }.resume()
    }
    
    
    //MARK: GET States & cities
    func fetchStatesCities() {
        guard let url = URL(string: "https://production.pgplanner.in/api/pgowner/getlistofstateandcitites") else {
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
                        let city = try JSONDecoder().decode(StateAndCity.self, from: data)
                        DispatchQueue.main.async {
                            self.CityResponse = city
                        }
                        print("API Response:", city)
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
    
    //MARK: GET Bookings
    func fetchBookingsData() {
        guard let url = URL(string: "https://production.pgplanner.in/api/user/getbookings") else {
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
                        let book = try JSONDecoder().decode(BookingResponse.self, from: data)
                        // Update the ProfileData property with the parsed user profile data
                        DispatchQueue.main.async {
                            self.bookResponse = book
                        }
                        
                        print("API Response:", book)
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
    
    //MARK: GET Notifications
    func getNotifications() {
        guard let url = URL(string: "https://production.pgplanner.in/api/pgowner/getnotifications") else {
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
                        let visit = try JSONDecoder().decode(NotificationResponse.self, from: data)
                        // Update the ProfileData property with the parsed user profile data
                        DispatchQueue.main.async {
                            self.notificationResponse = visit
                        }
                        
                        print("API Response:", visit)
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
    
    //MARK: PUT DOB
    func uploadDOB(dob: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        let urlString = "https://production.pgplanner.in/api/user/adduserdata"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        // Construct the parameters
        let parameters: [String: Any] = ["dob": dob]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            completion(.failure(NetworkError.encodingError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Fetch bearer token from AuthService
        if let bearerToken = getToken() {
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
    
    //MARK: PUT Modify DND
    func modifyDND(id: String, modification: DNDModification, completion: @escaping (Result<Data?, Error>) -> Void) {
        let urlString = "https://production.pgplanner.in/api/user/modifydnd/\(id)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        guard let jsonData = try? JSONEncoder().encode(modification) else {
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
    
    
    
    //MARK: POST Schedule Visit
    func PostscheduleVisit(pgid: String, date: String, time: String, noofpersons: Int, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://production.pgplanner.in/api/user/schedulevisit") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let parameters: [String: Any] = [
            "pgid": pgid,
            "date": date,
            "time": time,
            "noofpersons": noofpersons
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            completion(.failure(NSError(domain: "Failed to encode parameters", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
                if (200..<300).contains(httpResponse.statusCode) {
                    if let responseData = data {
                        if let responseString = String(data: responseData, encoding: .utf8) {
                            completion(.success(responseString))
                            return
                        }
                    }
                } else {
                    completion(.failure(NSError(domain: "HTTP Error: \(httpResponse.statusCode)", code: httpResponse.statusCode, userInfo: nil)))
                    return
                }
            }
            
            completion(.failure(NSError(domain: "Unknown error", code: 0, userInfo: nil)))
        }.resume()
    }
    
    
    //MARK: GET Schedule visit
    func fetchScheduleVisit() {
        guard let url = URL(string: "https://production.pgplanner.in/api/user/getvisits") else {
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
                        let visit = try JSONDecoder().decode(VisitResponse.self, from: data)
                        // Update the ProfileData property with the parsed user profile data
                        DispatchQueue.main.async {
                            self.visitResponse = visit
                        }
                        
                        print("API Response:", visit)
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
    
    //MARK: GET Booking datas
    func fetchBookings() {
        guard let url = URL(string: "https://production.pgplanner.in/api/user/getbookings") else {
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
                print("Error: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            print("Status Code: \(httpResponse.statusCode)")
            
            if let data = data {
                if let responseString = String(data: data, encoding: .utf8) {
                    print("API Response:")
                    print(responseString)
                }
            }
        }.resume()
    }
    
    //MARK: POST Expenses Items
    func addExpense(name: String, quantity: String, amount: String, selectedCategory: String, expenseGroupId: String,  completion: @escaping (Result<String, Error>) -> Void) {
        let url = URL(string: "https://production.pgplanner.in/api/user/addexpensetoexpensegroup")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let bearerToken = AuthService.shared.getToken() {
            request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        } else {
            print("Bearer token not available")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let currentDate = dateFormatter.string(from: Date())
        print("cuurent Date: \(currentDate)")
        
        let expenseData: [String: Any] = [
            "description": name,
            "expensegroupid": expenseGroupId,
            "category": "Food",
            "note": name,
            "unit": selectedCategory,
            "unitamount": Int(amount) ?? 0,
            "quantity": Int(quantity) ?? 0,
            "date": currentDate
        ]
        print("expenses Data: \(expenseData)")
        guard let jsonData = try? JSONSerialization.data(withJSONObject: expenseData) else {
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
                // Handle successful upload
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    print("Expenses data uploaded successfully")
                    completion(.success("Expenses data uploaded successfully"))
                } else {
                    // Handle upload failure
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Error: Failed to upload Expenses data"])
                    completion(.failure(error))
                }
            } else if let error = error {
                // Handle error
                print("Error:", error.localizedDescription)
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    //MARK: POST Group Name
    func uploadGroupName(groupName: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://production.pgplanner.in/api/user/addexpensegroup") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        print("group name : \(groupName)")
        let parameters: [String: Any] = [
            "title": groupName,
            "image": ""
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            completion(.failure(NSError(domain: "Failed to encode parameters", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
                if (200..<300).contains(httpResponse.statusCode) {
                    if let responseData = data {
                        if let responseString = String(data: responseData, encoding: .utf8) {
                            completion(.success(responseString))
                            return
                        }
                    }
                } else {
                    completion(.failure(NSError(domain: "HTTP Error: \(httpResponse.statusCode)", code: httpResponse.statusCode, userInfo: nil)))
                    return
                }
            }
            
            completion(.failure(NSError(domain: "Unknown error", code: 0, userInfo: nil)))
        }.resume()
    }
    
    //MARK: POST SignIN
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
    
    //MARK: POST SignUP
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
    
    //MARK: POST Notice
    @MainActor
    func postNoticePeriod() {
        isLoading = true
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.string(from: selectedDate)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let time = timeFormatter.string(from: selectedTime)
        
        let parameters = [
            "vacatedate": date,
            "vacatetime": time
        ]
        print("requestBody : \(parameters)")
        guard let url = URL(string: "https://production.pgplanner.in/api/user/addnoticeperiod") else {
            print("Invalid URL")
            isLoading = false
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let bearerToken = getToken() {
            request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        } else {
            print("Bearer token not available")
            isLoading = false
            DispatchQueue.main.async {
                self.noticePeriodResponse = nil // Reset response string
            }
            return
        }
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            print("Error serializing JSON: \(error.localizedDescription)")
            isLoading = false
            DispatchQueue.main.async {
                self.noticePeriodResponse = nil // Reset response string
            }
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                DispatchQueue.main.async {
                    self.noticePeriodResponse = nil // Reset response string
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
                DispatchQueue.main.async {
                    self.noticePeriodResponse = responseString // Update response string
                }
            }
        }.resume()
    }
    
    //MARK: POST DND
    func uploadDND2(startingDate: String, expectedReturnDate: String, returningMeal: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        let url = URL(string: "https://production.pgplanner.in/api/user/adddnd")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let bearerToken = AuthService.shared.getToken() {
            request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        } else {
            print("Bearer token not available")
            return
        }
        
        // Prepare request body
        let requestBody: [String: Any] = [
            "returningmeal": returningMeal,
            "startingdate": startingDate,
            "expectedreturndate": expectedReturnDate
        ]
        print("requestBody : \(requestBody)")
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
                    //self.noticePeriodResponse = responseString
                }
                // Handle successful upload
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    print("DND data uploaded successfully")
                    completion(.success("DND data uploaded successfully"))
                } else {
                    // Handle upload failure
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Error: Failed to upload DND data"])
                    completion(.failure(error))
                }
            } else if let error = error {
                // Handle error
                print("Error:", error.localizedDescription)
                completion(.failure(error))
            }
        }.resume()
    }
    
    //MARK: POST Host Friend
    func uploadHost(name: String, email: String, phone: String, entrydate: String, entrytime: String, exitdate: String, exittime: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        let url = URL(string: "https://production.pgplanner.in/api/user/hostafriend")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let bearerToken = AuthService.shared.getToken() {
            request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        } else {
            print("Bearer token not available")
            return
        }
        
        // Prepare request body
        let requestBody: [String: Any] = [
            "name": name,
            "email": email,
            "phone": phone,
            "entrydate": entrydate,
            "entrytime": entrytime,
            "exitdate": exitdate,
            "exittime": exittime,
        ]
        print("requestBody : \(requestBody)")
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
                    //self.noticePeriodResponse = responseString
                }
                // Handle successful upload
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    print("Host Friend uploaded successfully")
                    completion(.success("Host Friend uploaded successfully"))
                } else {
                    // Handle upload failure
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Error: Failed to upload Host Friend data"])
                    completion(.failure(error))
                }
            } else if let error = error {
                // Handle error
                print("Error:", error.localizedDescription)
                completion(.failure(error))
            }
        }.resume()
    }
    
    //MARK: POST Skip Menu
    func toggleSkipMenu(day: String, meal: String, newValue: Bool) {
        if skipMenu[day] != nil {
            skipMenu[day]?[meal] = newValue
        } else {
            skipMenu[day] = [meal: newValue]
        }
        updateSkipMenu()
    }
    
    private func updateSkipMenu() {
        guard let url = URL(string: "https://production.pgplanner.in/api/user/setupskipmenu") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Fetch bearer token from AuthService
        if let bearerToken = AuthService.shared.getToken() {
            request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        } else {
            print("Bearer token not available")
            return
        }
        
        
        let parameters: [String: Any] = ["skipmenu": skipMenu]
        print("parameters: \(parameters)")
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        print("Request parameters: \(parameters)")
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            if let response = response as? HTTPURLResponse {
                print("Response status code: \(response.statusCode)")
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response data: \(responseString)")
            }
        }.resume()
    }
    
    //MARK: GET PGs for User
    func getPGDetailsForUser(_ id: String,completion: @escaping (Result<PGDetailsResponse, Error>) -> Void) {
        let token = AuthService.shared.getToken()
        // Prepare your API request
        let bearerToken = "Bearer \(token)"
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
    
    //MARK: GET User Data
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
                        
                        print("API Response:", userProfile)
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
    
    //MARK: GET Room Data
    func getUserRoomDetails() {
        guard let url = URL(string: "https://production.pgplanner.in/api/user/roomdetails") else {
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
                        let userProfile = try JSONDecoder().decode(RoomDetailsResponse.self, from: data)
                        // Update the ProfileData property with the parsed user profile data
                        DispatchQueue.main.async {
                            self.room = userProfile
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
    
    //MARK: Get Skip Menu
    func fetchSkipMenu() {
        guard let url = URL(string: "https://production.pgplanner.in/api/user/getskipmenu") else {
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
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(SkipMenuResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.skipMenu = decodedData.skipmenu
                    }
                    print("Ski data: \(decodedData)")
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else {
                print("No data received")
            }
        }.resume()
    }
    
    //MARK: GET PG Data
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
    
    
    //MARK: Get Today's Menu
    func fetchTodaysMenuData(completion: @escaping (MenuResponse?) -> Void) {
        guard let url = URL(string: "https://production.pgplanner.in/api/user/gettodaysmenu") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let bearerToken = AuthService.shared.getToken() {
            request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        } else {
            print("Bearer token not available")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                completion(nil)
                return
            }
            print("Status code: \(httpResponse.statusCode)")
            if let data = data {
                do {
                    let menuResponse = try JSONDecoder().decode(MenuResponse.self, from: data)
                    completion(menuResponse)
                    print("JSON Response menu: \(menuResponse)")
                    
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(nil)
                }
            }
        }.resume()
    }
    
    //MARK: PUT User Data
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
    
    //MARK: PUT Profie Image
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
    
    //MARK: PUT Aadhar Image
    func uploadAadharCard(image: UIImage, completion: @escaping (Bool) -> Void) {
        // Convert UIImage to Data
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Failed to convert image to data.")
            completion(false)
            return
        }
        
        // Prepare URL Request
        guard let url = URL(string: "https://production.pgplanner.in/api/user/uploadaadhar") else {
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
        body.append("Content-Disposition: form-data; name=\"aadhar\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
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
    
    //MARK: PUT Driving Image
    func uploadDrivingLicense(image: UIImage, completion: @escaping (Bool) -> Void) {
        // Convert UIImage to Data
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Failed to convert image to data.")
            completion(false)
            return
        }
        
        // Prepare URL Request
        guard let url = URL(string: "https://production.pgplanner.in/api/user/uploadlicense") else {
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
        body.append("Content-Disposition: form-data; name=\"license\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
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
    
    //MARK: Get Rent Table
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
                    let jsonString = String(data: data, encoding: .utf8) ?? "Data could not be printed"
                    print("JSON Response: \(jsonString)")
                    
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
    
    //MARK: Get Wallet Data
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
    
    //MARK: Get DND
    func getDND() {
        // Construct the URL for the getDND endpoint
        guard let url = URL(string: "https://production.pgplanner.in/api/user/getdnd") else {
            print("Invalid URL")
            return
        }
        
        // Create URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let bearerToken = AuthService.shared.getToken() {
            request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        } else {
            print("Bearer token not available")
            return
        }
        // Perform the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(DNDResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.dndData["Active DND"] = decodedData.ongoingdnd.map { dndItem in
                            DNDItem(_id: dndItem._id, startdate: dndItem.startdate, expectedreturndate: dndItem.expectedreturndate, returningmeal: dndItem.returningmeal, days: dndItem.days)
                        }
                        self.dndData["Past DND"] = decodedData.pastdnd.map { dndItem in
                            DNDItem(_id: dndItem._id,startdate: dndItem.startdate, expectedreturndate: dndItem.expectedreturndate, returningmeal: dndItem.returningmeal, days: dndItem.days)
                        }
                        self.dndData["Pending DND"] = decodedData.pendingdnd.map { dndItem in
                            DNDItem(_id: dndItem._id,startdate: dndItem.startdate, expectedreturndate: dndItem.expectedreturndate, returningmeal: dndItem.returningmeal, days: dndItem.days)
                        }
                    }
                    print("APi DND Response: \(decodedData)")
                    
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else {
                print("No data received")
            }
        }.resume()
    }
    
    //MARK: Get Notice
    func getNoticePeriod() {
        guard let url = URL(string: "https://production.pgplanner.in/api/user/getnoticeperiod") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let bearerToken = getToken() {
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
                    let decodedData = try JSONDecoder().decode(NoticePeriodData.self, from: data)
                    DispatchQueue.main.async {
                        self.noticePeriodData = decodedData
                    }
                    print("APi notice  Response: \(decodedData)")
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
    
    //MARK: DEL DND
    func deleteDND(id: String) {
        guard let url = URL(string: "https://production.pgplanner.in/api/user/deletednd/\(id)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        if let bearerToken = getToken() {
            request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        } else {
            print("Bearer token not available")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Response Status Code: \(httpResponse.statusCode)")
                if httpResponse.statusCode == 204 {
                    print("DND deleted successfully!")
                } else {
                    print("Failed to delete DND")
                }
            }
        }.resume()
    }
    
    //MARK: DEL Expenses Group
    func deleteExpenseGroup(expenseID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "https://production.pgplanner.in/api/user/deleteexpensegroup/\(expenseID)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
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
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            
            if httpResponse.statusCode == 200 {
                completion(.success(()))
            } else {
                completion(.failure(NSError(domain: "Failed to delete expense. Status code: \(httpResponse.statusCode)", code: httpResponse.statusCode, userInfo: nil)))
            }
        }.resume()
    }
    
    //MARK: DEL Expenses
    func deleteExpense(expenseID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "https://production.pgplanner.in/api/user/deleteexpense/\(expenseID)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
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
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            
            if httpResponse.statusCode == 200 {
                completion(.success(()))
            } else {
                completion(.failure(NSError(domain: "Failed to delete expense. Status code: \(httpResponse.statusCode)", code: httpResponse.statusCode, userInfo: nil)))
            }
        }.resume()
    }
    
    
    
    //MARK: Get  All Expenses
    func getAllExpenses2(completion: @escaping (Result<[Expense], Error>) -> Void) {
        // Construct URL without parameters
        let url = URL(string: "https://production.pgplanner.in/api/user/getallexpensesofuser")!
        
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
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(ExpensesResponse.self, from: data)
                    DispatchQueue.main.async {
                        let expenses = decodedResponse.expensesdata.map { expenseData in
                            let expenses = expenseData.expenses.map { expense in
                                ExpenseDetail(_id: expense._id,
                                              description: expense.description,
                                              category: expense.category,
                                              unitAmount: expense.unitamount,
                                              totalAmount: expense.totalamount,
                                              date: expense.date,
                                              image: expense.image,
                                              quantity: expense.quantity,
                                              unit: expense.unit)
                            }
                            return Expense(_id: expenseData._id,
                                           title: expenseData.title,
                                           image: expenseData.image,
                                           expenses: expenses)
                        }
                        self.expenses = expenses
                        completion(.success(expenses))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    
    //MARK: Get Device Token
    func getDeviceToken() -> String? {
        guard let deviceToken = UIDevice.current.identifierForVendor?.uuidString else {
            return nil
        }
        return deviceToken
    }
    
    //MARK: Upload Device Token
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
        UserDefaults.standard.set(token, forKey: "userToken")
    }
    
    func getToken() -> String? {
        return UserDefaults.standard.string(forKey: "userToken")
        print("$$$$\(UserDefaults.standard.string(forKey: "userToken"))")
    }
    
    func clearToken() {
        UserDefaults.standard.removeObject(forKey: "userToken")
        isLoggedIn = false
    }
    
    enum NetworkError: Error {
        case encodingError, invalidURL
    }
}
