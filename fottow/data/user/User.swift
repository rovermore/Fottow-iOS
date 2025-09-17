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
    let token: String
    let user: User
}

struct LoginRequest: Codable {
    let userName: String
    let password: String
    let fcm: String
    
    private enum CodingKeys: String, CodingKey {
            case userName = "username" // Mapea la clave JSON "username" a la propiedad userName
            case password
            case fcm
        }
}

struct RegisterResponse: Codable {
    let token: String
    let message: String
}

struct RegisterRequest: Codable {
    let userName: String
    let password: String
    let nickName: String
    let fcm: String
    
    private enum CodingKeys: String, CodingKey {
            case userName = "username"
            case password
            case fcm
            case nickName = "nick"
        }
}
