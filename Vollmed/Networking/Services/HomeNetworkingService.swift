//
//  HomeNetworkingService.swift
//  Vollmed
//
//  Created by Erica Rodrigues on 07/10/25.
//

import Foundation

protocol HomeServiceable {
    func getAllSpecialists() async throws -> Result<[Specialist]?, RequestError>
}

struct HomeNetworkingService: HTTPClient, HomeServiceable {
    func getAllSpecialists() async throws -> Result<[Specialist]?, RequestError> {
        return await  sendRequest(endpoint: HomeEndpoint.getAllSpecialist, responseModel: [Specialist].self)
    }
}
