//
//  MyAppointmentsView.swift
//  Vollmed
//
//  Created by Erica Rodrigues on 02/08/25.
//

import SwiftUI

struct MyAppointmentsView: View {
    
    let service = WebService()
    
    @State private var appointments: [Appointment] = []
    
    func getAllAppointmentsFromPatient() async {
        do {
            if let appointments = try await service.getAllAppointmentsFromPatient(patientId: patientId) {
                self.appointments = appointments
            }
        } catch {
            print("Ocorreu um erro ao buscar os especialistas: \(error)")
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(appointments) { appointment in
                SpecialistCardView(specialist: appointment.specialist, appointment: appointment
                 )
            }
        }
        .navigationTitle("Minhas consultas")
        .navigationBarTitleDisplayMode(.large)
        .padding()
        .onAppear {
            Task {
                await getAllAppointmentsFromPatient()
            }
        }
    }
}

#Preview {
    MyAppointmentsView()
}
