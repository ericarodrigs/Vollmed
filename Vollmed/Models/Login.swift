//
//  Login.swift
//  Vollmed
//
//  Created by Erica Rodrigues on 05/10/25.
//

import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case password = "senha"
    }
}

struct LoginResponse: Codable {
    let auth: Bool
    let token: String
    let rota: String
}
