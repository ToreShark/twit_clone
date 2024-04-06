//
//  AuthViewModel.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 04.04.2024.
//

import SwiftUI

struct ErrorResponse: Decodable {
    let statusCode: Int
    let error: String
    let message: String
}


class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    
    static let shared = AuthViewModel()
    @EnvironmentObject var viewModel: AuthViewModel
    
    init() {
        let defaults = UserDefaults.standard
        if let token = defaults.object(forKey: "jsonwebtoken") as? String,
           let userId = defaults.object(forKey: "userid") as? String {
            print("Token found: \(token)")
            isAuthenticated = true
            fetchUser(userId: userId)
        } else {
            isAuthenticated = false
            print("No token found")
        }
    }
    
    func login(email: String, password: String) {
        print("Logging in user with email: \(email)")
        AuthServices.login(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let apiResponse):
                print("Login successful, access token: \(apiResponse.accessToken)")
                DispatchQueue.main.async {
                    UserDefaults.standard.setValue(apiResponse.accessToken, forKey: "jsonwebtoken")
                    self?.isAuthenticated = true
                    self?.currentUser = apiResponse.user
                }
            case .failure(let error):
                print("Login failed with error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.isAuthenticated = false
                }
            }
        }
    }

    
    func register(name: String, username: String, email: String, password: String) {
        print("Registering user with email: \(email) and username: \(username)")
        AuthServices.register(email: email, username: username, password: password, name: name) {
            result in switch result {
                
            case .success(let data):
                if let responseData = try? JSONDecoder().decode(ApiResponse.self, from: data!) {
                    DispatchQueue.main.async {
                        UserDefaults.standard.setValue(responseData.accessToken, forKey: "jsonwebtoken")
                        UserDefaults.standard.setValue(responseData.user.id, forKey: "userid")
                        self.isAuthenticated = true
                        self.currentUser = responseData.user
                        print(responseData.user.email)
                    }
                } else {
                    // If decoding into ApiResponse fails, try to decode into a common error response model
                    if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data!) {
                        print("Error: \(errorResponse.message)")
                    } else {
                        print("Error: Couldn't decode data into ApiResponse or common error model")
                    }
                }
            case .failure(let error):
                print("Registration failed with error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchUser(userId: String) {
        print("Fetching user with ID: \(userId)")
        
        AuthServices.fetchUser(id: userId) { [weak self] result in
            switch result {
            case .success(let data):
                guard let data = data,
                      let user = try? JSONDecoder().decode(User.self, from: data) else {
                    print("Failed to decode user data")
                    return
                }
                DispatchQueue.main.async {
                    UserDefaults.standard.setValue(user.id, forKey: "userid")
                    self?.isAuthenticated = true
                    self?.currentUser = user
                    print("User fetched: \(user.email)")
                }
            case .failure(let error):
                print("Failed to fetch user with error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.isAuthenticated = false
                }
            }
        }
    }
    func logout() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        
        DispatchQueue.main.async {
            self.isAuthenticated = false
            self.currentUser = nil
        }
    }
}
