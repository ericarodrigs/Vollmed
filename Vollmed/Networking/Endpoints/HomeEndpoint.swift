//
//  HomeEndpoint.swift
//  Vollmed
//
//  Created by Erica Rodrigues on 07/10/25.
//

import Foundation

enum HomeEndpoint {
    case getAllSpecialist
}

extension HomeEndpoint: Endpoint {
    var path: String {
        switch self{
        case .getAllSpecialist:
            return "/especialista"
        }
    }
    
    var method: RequestMethod {
        switch self{
        case .getAllSpecialist:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self{
        case .getAllSpecialist:
            return nil
        }
    }
    
    var body: [String : String]? {
        switch self{
        case .getAllSpecialist:
            return nil
        }
    }
    
    
}
