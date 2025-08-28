//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by Erica Rodrigues on 02/08/25.
//

import SwiftUI

struct ScheduleAppointmentView: View {
    
    let service = WebService()
    
    var specialistId: String
    var isRescheduleAppointment: Bool
    var appointmentId: String?
    
    @State private var selectedDate = Date()
    @State private var showAlert = false
    @State private var isAppointmentScheduled = false
    @State private var message: String?
    
    init(specialistId: String, isRescheduleAppointment: Bool = false, appointmentId: String? = nil) {
        self.specialistId = specialistId
        self.isRescheduleAppointment = isRescheduleAppointment
        self.appointmentId = appointmentId
    }
    
    func rescheduleAppointment() async {
        guard let appointmentId else {
            print("Houve um erro ao obter o ID da consulta")
            return
        }
        
        do {
            if let response = try await service.rescheduleAppointment(appointmentId: appointmentId, date: selectedDate.convertToString()) {
                isAppointmentScheduled = true
                
                if(response.message != nil){
                    isAppointmentScheduled = false
                    message = response.message
                }
            } else {
                isAppointmentScheduled = false
            }
        } catch {
            isAppointmentScheduled = false
            print("Ocorreu um erro ao agendar consulta \(error)")
        }
        showAlert = true
    }
    
    func scheduleAppointment() async {
        do {
            if let response = try await service.scheduleAppointment(specialistId: specialistId, patientId: patientId, date: selectedDate.convertToString()) {
                isAppointmentScheduled = true
                
                if(response.message != nil){
                    isAppointmentScheduled = false
                    message = response.message
                }
            } else {
                isAppointmentScheduled = false
            }
        } catch {
            isAppointmentScheduled = false
            print("Ocorreu um erro ao agendar consulta \(error)")
        }
        showAlert = true
    }
    
    var body: some View {
        VStack {
            Text("Selecione a data e o horário da consulta")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            DatePicker("Escolha a data da consulta", selection: $selectedDate, in: Date()...)
                .datePickerStyle(.graphical)
            
            Button {
                Task {
                    isRescheduleAppointment ? await rescheduleAppointment() : await scheduleAppointment()
                }
            } label: {
                ButtonView(text: isRescheduleAppointment ? "Reagendar consulta" : "Agendar consulta")
            }
            
        }
        .padding()
        .navigationTitle(isRescheduleAppointment ? "Reagendar consulta" : "Agendar consulta")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            UIDatePicker.appearance().minuteInterval = 15
        }
        .alert(isAppointmentScheduled ? "Sucesso" :  "Ops, algo deu errado", isPresented: $showAlert, presenting: isAppointmentScheduled) { isSchedule in
            Button(action: {}, label: {
                Text("OK")
            })
        } message: { isSchedule in
            isSchedule ? Text("A consulta foi \(isRescheduleAppointment ? "reagendada" : "agendada") com sucesso") : Text(message ?? "Houve um erro ao \(isRescheduleAppointment ? "reagendar" : "agendar") a consulta, tente novamente ou entre em contato via telefone")
        }
    }
}

#Preview {
    ScheduleAppointmentView(specialistId: "12345")
}
