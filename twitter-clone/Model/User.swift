//
//  User.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 04.04.2024.
//

import Foundation

struct ApiResponse: Decodable {
    var user: User
    var accessToken: String
}

struct User: Decodable, Identifiable {
    var _id: String
    var id: String {
        return _id
    }
    let username: String
    let name: String
    let email: String
    var location: String?
    var bio: String?
    var website: String?
    var avatarExists: Bool?
    var followers: [String]
    var followings: [String]
}
