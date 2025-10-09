//
//  AuthenticationNetworkingService.swift
//  Vollmed
//
//  Created by Erica Rodrigues on 09/10/25.
//

import Foundation

protocol AuthenticationServiceable {
    func logout() async -> Result<Bool?, RequestError>
}

struct AuthenticationNetworkingService: HTTPClient, AuthenticationServiceable {
    func logout() async -> Result<Bool?, RequestError> {
        return await  sendRequest(endpoint: AuthenticationEndpoint.logout, responseModel: nil)
    }
}
