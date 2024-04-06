//
//  AuthServices.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 04.04.2024.
//

import Foundation
import SwiftUI

enum NetWorkError: Error {
    case invalidUrl
    case noData
    case descodingError
}

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

public class AuthServices {
    public static var requestDomain = ""
    
    // create login method: email, password, completion
    static func login(email: String, password: String, completion: @escaping (_ result: Result<ApiResponse, AuthenticationError>) -> Void) {
        guard let urlString = URL(string: "http://localhost:3000/authentication/sign-in") else {
            print("Invalid URL")
            completion(.failure(.custom(errorMessage: "Invalid URL")))
            return
        }
        
        makeRequest(urlString: urlString, reqBody: ["email": email, "password": password]) { result in
            switch result {
            case .success(let data):
                guard let data = data,
                      let apiResponse = try? JSONDecoder().decode(ApiResponse.self, from: data) else {
                    print("Error: Couldn't decode data into ApiResponse")
                    completion(.failure(.custom(errorMessage: "Failed to decode ApiResponse")))
                    return
                }
                completion(.success(apiResponse))
                
            case .failure(let error):
                print("Network error: \(error)")
                completion(.failure(.custom(errorMessage: "Network request failed")))
            }
        }
    }
    
    
    static func register(email: String, username: String, password: String, name: String, completion: @escaping (_ result: Result<Data?, AuthenticationError>) -> Void) {
        guard let urlString = URL(string: "http://localhost:3000/user") else {
            print("Invalid URL")
            completion(.failure(.custom(errorMessage: "Invalid URL")))
            return
        }
        
        makeRequest(urlString: urlString, reqBody: ["email": email, "username": username, "name": name, "password": password]) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print("Network error: \(error)")
                completion(.failure(.custom(errorMessage: "Network request failed")))
            }
        }
    }
    
    static func makeRequest(urlString: URL, reqBody: [String: Any], completion: @escaping (_ result: Result<Data?, NetWorkError>) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: reqBody, options: [])
        } catch let error {
            print("JSON serialization error: \(error)")
            completion(.failure(.descodingError))
            return
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            
            if let error = error {
                print("HTTP request error: \(error)")
                completion(.failure(.invalidUrl))
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(.failure(.noData))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print("Response JSON: \(json)")
                }
                completion(.success(data))
            } catch let error {
                print("JSON decoding error: \(error)")
                completion(.failure(.descodingError))
            }
        }
        task.resume()
    }
    static func fetchUser(id: String, completion: @escaping (_ result: Result<Data?, AuthenticationError>) -> Void) {
        let urlString = "http://localhost:3000/users/\(id)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(.failure(.custom(errorMessage: "Invalid URL")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("HTTP request error: \(error)")
                completion(.failure(.custom(errorMessage: "Network request failed")))
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(.failure(.custom(errorMessage: "No data received")))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
}
