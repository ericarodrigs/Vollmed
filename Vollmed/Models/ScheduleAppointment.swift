//
//  ScheduleAppointment.swift
//  Vollmed
//
//  Created by Erica Rodrigues on 02/08/25.
//

import Foundation

struct ScheduleAppointmentResponse: Codable, Identifiable {
    let id: String?
    let specialist: String?
    let patient: String?
    let date: String?
    let reasonToCancel: String?
    let status: Int?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case specialist = "especialista"
        case patient = "paciente"
        case date = "data"
        case reasonToCancel = "motivoCancelamento"
        case status
        case message
    }
}

struct ScheduleAppointmentRequest: Codable {
    let specialist: String
    let patient: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case specialist = "especialista"
        case patient = "paciente"
        case date = "data"
    }
}
