//
//  User.swift
//  fottow
//
//  Created by Rober on 15/9/25.
//

import Foundation

struct User: Codable {
    let userName: String //email
    let nick: String
    let profileImage: String
    
    private enum CodingKeys: String, CodingKey {
            case userName = "username" // Mapea la clave JSON "username" a la propiedad userName
            case nick
            case profileImage = "profile_image" // Mapea la clave JSON "profile_image" a la propiedad profileImage
        }
}

struct LoginResponse: Codable {
    let token: String?
    let user: User?
}

struct LoginRequest: Codable {
    let username: String
    let password: String
    let fcm: String
}
