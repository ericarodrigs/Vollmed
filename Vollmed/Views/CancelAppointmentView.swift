//
//  CancelAppointmentView.swift
//  Vollmed
//
//  Created by Erica Rodrigues on 28/08/25.
//

import SwiftUI

struct CancelAppointmentView: View {
    var appointmentId: String
    let service = WebService()
    
    @State private var reasonToCancel = ""
    @State private var showAlert = false
    @State private var isAppointmentCanceled = false
    
    func cancelAppointment() async {
        do {
            if try await service.cancelAppointment(appointmentId: appointmentId, reasonToCancel: reasonToCancel) {
                print("Consulta cancelada com sucesso")
                isAppointmentCanceled = true
            }
        } catch {
            print("Ocorreu um erro ao cancelar a consulta \(error)")
            isAppointmentCanceled = false
        }
        showAlert = true
    }
    
    var body: some View {
        VStack(spacing: 16.0) {
            Text("Conte-nos o motivo do cancelamento da sua consulta")
                .font(.title3)
                .bold()
                .foregroundColor(.accent)
                .padding(.top)
                .multilineTextAlignment(.center)
            
            TextEditor(text: $reasonToCancel)
                .padding()
                .font(.title3)
                .foregroundStyle(.accent)
                .scrollContentBackground(.hidden)
                .background(Color(.lightBlue).opacity(0.15))
                .cornerRadius(16.0)
                .frame(maxHeight: 300)
            
            Button(action: {
                Task {
                    await cancelAppointment()
                }
            }) {
                ButtonView(text: "Cancelar consulta", buttonType: .cancel)
            }
        }
        .padding()
        .navigationTitle("Cancelar consulta")
        .navigationBarTitleDisplayMode(.large)
        .alert(isAppointmentCanceled ? "Sucesso" : "Ops, algo deu errado", isPresented: $showAlert, presenting: isAppointmentCanceled) { isCanceled in
            Button(action: {}, label: {
                Text("OK")
            })
        } message: { isCanceled in
            isCanceled ? Text("A consulta foi cancelada com sucesso") : Text("Houve um erro ao cancelar a consulta, tente novamente ou entre em contato via telefone")
        }
    }
}

#Preview {
    CancelAppointmentView(appointmentId: "123")
}
