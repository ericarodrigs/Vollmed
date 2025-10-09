//
//  RequestError.swift
//  Vollmed
//
//  Created by Erica Rodrigues on 07/10/25.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unknown
    case custom(_ error: [String: Any])
    
    var customMessage: String {
        switch self {
        case .decode:
            return "erro de codificação"
        case .unauthorized:
            return "sessão expirada"
        default:
            return "erro desconhecido"
        }
    }
}
