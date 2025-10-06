//
//  AuthenticationManager.swift
//  Vollmed
//
//  Created by Erica Rodrigues on 06/10/25.
//

import Foundation

class AuthenticationManager: ObservableObject {
    
    static let shared = AuthenticationManager()
    
    @Published var token: String?
    @Published var patientId: String?
    
    private init() {
        self.token = KeychainHelper.get(for: "app-vollmed-token")
        self.patientId = KeychainHelper.get(for: "app-vollmed-patient-id")
    }
    
    func saveToken(token: String) {
        KeychainHelper.save(value: token, key: "app-vollmed-token")
        self.token = token
    }
    
    func removeToken() {
        KeychainHelper.remove(for: "app-vollmed-token")
        self.token = nil
    }
    
    func savePatientId(id: String) {
        KeychainHelper.save(value: id, key: "app-vollmed-patient-id")
        self.patientId = id
    }
    
    func removePatientId() {
        KeychainHelper.remove(for: "app-vollmed-patient-id")
        self.patientId = nil
    }
}
