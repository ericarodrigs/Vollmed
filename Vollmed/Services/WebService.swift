//
//  WebService.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import UIKit

struct WebService {
    
    private let baseURL = "http://localhost:3000"
    
    func loginPatient(email: String, password: String) async throws -> LoginResponse? {
        let endpoint = "\(baseURL)/auth/login"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }
        
        let loginRequest = LoginRequest(email: email, password: password)
        
        let jsonData = try JSONEncoder().encode(loginRequest)
        print(String(data: jsonData, encoding: .utf8)!)
       
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        print(String(data: data, encoding: .utf8) ?? "Resposta vazia")
        
        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
        
        return loginResponse
    }
    
    func registerPatient(patient: Patient) async throws -> Patient? {
        let endpoint = "\(baseURL)/paciente"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }
        
        let jsonData = try JSONEncoder().encode(patient)
        print(String(data: jsonData, encoding: .utf8)!)
       
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        print(String(data: data, encoding: .utf8) ?? "Resposta vazia")
        
        let patient = try JSONDecoder().decode(Patient.self, from: data)
        
        return patient
    }
    
    func cancelAppointment(appointmentId: String, reasonToCancel: String) async throws -> Bool {
        let endpoint = "\(baseURL)/consulta/\(appointmentId)"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return false
        }
        
        guard let token = UserDefaultsHelper.get(for: "token") else {
                    print("Token não informado")
                    return false
                }
        
        let requestData: [String: String] = ["motivoCancelamento": reasonToCancel]
        let jsonData = try JSONSerialization.data(withJSONObject: requestData)
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            return true
        }
        
        return false
    }
    
    func rescheduleAppointment(appointmentId: String, date: String) async throws -> ScheduleAppointmentResponse? {
        let endpoint = "\(baseURL)/consulta/\(appointmentId)"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }
        
        guard let token = UserDefaultsHelper.get(for: "token") else {
                    print("Token não informado")
                    return nil
                }
        
        let requestData: [String: String] = ["data": date]
        let jsonData = try JSONSerialization.data(withJSONObject: requestData)
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let appointmentResponse = try JSONDecoder().decode(ScheduleAppointmentResponse.self, from: data)
        return appointmentResponse
    }
    
    func getAllAppointmentsFromPatient(patientId: String) async throws -> [Appointment]? {
        let endpoint = "\(baseURL)/paciente/\(patientId)/consultas"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }
        
        guard let token = UserDefaultsHelper.get(for: "token") else {
                    print("Token não informado")
                    return nil
                }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let appointments = try JSONDecoder().decode([Appointment].self, from: data)
        
        return appointments
    }
    
    func scheduleAppointment(specialistId: String,
                             patientId: String,
                             date: String) async throws -> ScheduleAppointmentResponse? {
        let endpoint = baseURL + "/consulta"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }
        
        guard let token = UserDefaultsHelper.get(for: "token") else {
            print("Token não informado")
            return nil
        }
        
        let appointment = ScheduleAppointmentRequest(specialist: specialistId, patient: patientId, date: date)
        
        let jsonData = try JSONEncoder().encode(appointment)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let appointmentResponse = try JSONDecoder().decode(ScheduleAppointmentResponse.self, from: data)
        return appointmentResponse
    }
    
    func downloadImage(from imageUrl: String) async throws -> UIImage? {
        guard let url = URL(string: imageUrl) else {
            print("Erro na URL!")
            return nil
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return UIImage(data: data)
    }
    
    func getAllSpecialists() async throws -> [Specialist]? {
        let endpoint = baseURL + "/especialista"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let specialists = try JSONDecoder().decode([Specialist].self, from: data)
        
        return specialists
    }
}
