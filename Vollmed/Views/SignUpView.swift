//
//  SignUpView.swift
//  Vollmed
//
//  Created by Erica Rodrigues on 04/10/25.
//

import SwiftUI

struct SignUpView: View {
    let service = WebService()
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var cpf: String = ""
    @State private var phoneNumber: String = ""
    @State private var healthPlan: String
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var isPatientRegistered: Bool = false
    @State private var navigateToSingInView: Bool = false
    
    let healthPlans: [String] = [
        "Amil", "Unimed", "Bradesco", "SulAmerica", "Hapvida", "Notredame", "São Francisco", "Outro"
    ]
    
    init() {
        self.healthPlan = healthPlans[0]
    }
    
    func registerPatient() async {
        let patient = Patient(id: nil, cpf: cpf, name: name, email: email, password: password, phoneNumber: phoneNumber, healthPlan: healthPlan)
        do {
            if let response = try await service.registerPatient(patient: patient) {
                isPatientRegistered = true
                KeychainHelper.save(value: response.id ?? "", key: "app-vollmed-patient-id")
                print("Paciente foi cadastrado com sucesso!")
            } else {
                isPatientRegistered = false
            }
        } catch {
            isPatientRegistered = false
            print("Ocorreu um erro ao cadastrar o paciente \(error)")
        }
        showAlert = true
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16.0) {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 36.0, alignment: .center)
                    .padding(.vertical)

                Text("Olá, boas-vindas!")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.accent)

                Text("Insira seus dados para criar uma conta")
                    .font(.title3)
                    .foregroundStyle(.gray)
                    .padding(.bottom)
                
                Text("Nome")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                 
                TextField("Insira seu nome completo", text: $name)
                    .padding(14.0)
                    .background(Color.gray.opacity(0.25))
                    .cornerRadius(14.0)
                    .autocorrectionDisabled()
                
                Text("Email")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                 
                TextField("Insira seu email", text: $email)
                    .padding(14.0)
                    .background(Color.gray.opacity(0.25))
                    .cornerRadius(14.0)
                    .autocorrectionDisabled()
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never )
                
                Text("CPF")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                 
                TextField("Insira seu CPF", text: $cpf)
                    .padding(14.0)
                    .background(Color.gray.opacity(0.25))
                    .cornerRadius(14.0)
                    .autocorrectionDisabled()
                    .keyboardType(.numberPad)
                
                Text("Telefone")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                 
                TextField("Insira seu telefone", text: $phoneNumber)
                    .padding(14.0)
                    .background(Color.gray.opacity(0.25))
                    .cornerRadius(14.0)
                    .keyboardType(.numberPad)
                
                Text("Senha")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                 
                SecureField("Insira sua senha", text: $password)
                    .padding(14.0)
                    .background(Color.gray.opacity(0.25))
                    .cornerRadius(14.0)
                
                Text("Selecione o seu plano de saúde")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                Picker("Plano de saúde", selection: $healthPlan) {
                    ForEach(healthPlans, id: \.self) {healthPlan in
                        Text(healthPlan)
                    }
                }
                
                Button (action: {
                    Task {
                        await registerPatient()
                    }
                }, label: {
                    ButtonView(text: "Cadastrar")
                })
                
                NavigationLink {
                    SignInView()
                } label: {
                    Text("Já possui conta? Faça o login!")
                        .bold()
                        .foregroundStyle(.accent)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .padding()
        .alert(isPatientRegistered ? "Sucesso!" : "Ops, deu algo errado!", isPresented: $showAlert, presenting: $isPatientRegistered) { _ in
            Button(action: {
                navigateToSingInView = true
            }, label: {
                Text("OK")
            })
        } message: { _ in
            isPatientRegistered ? Text("O paciente foi criado com sucesso!") : Text("Houve um erro ao cadastrar o paciente. Por favor, tente novamente.")
        }
        .navigationDestination(isPresented: $navigateToSingInView) {
            SignInView()
        }
    }
}

#Preview {
    SignUpView()
}
