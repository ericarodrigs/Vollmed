//
//  ScheduleAppointment.swift
//  Vollmed
//
//  Created by Erica Rodrigues on 02/08/25.
//

import Foundation

struct ScheduleAppointmentResponse: Codable, Identifiable {
    let id: String
    let specialist: String
    let pacient: String
    let date: String
    let reasonToCancel: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case specialist = "especialista"
        case pacient = "paciente"
        case date = "data"
        case reasonToCancel = "motivoCancelamento"
    }
}

struct ScheduleAppointmentRequest: Codable {
    let specialist: String
    let pacient: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case specialist = "especialista"
        case pacient = "paciente"
        case date = "data"
    }
}
