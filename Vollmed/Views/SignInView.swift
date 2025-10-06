//
//  SignInView.swift
//  Vollmed
//
//  Created by Erica Rodrigues on 04/10/25.
//

import SwiftUI

struct SignInView: View {
    
    let service = WebService()

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var showLoading: Bool = false

    func loginPatient() async {
        do {
            if let response = try await service.loginPatient(email: email, password: password) {
                KeychainHelper.save(value: response.token, key: "app-vollmed-token")
            } else {
                showAlert = true
            }
        } catch {
            showAlert = true
            print("Ocorreu um erro ao logar o paciente \(error)")
        }
        showLoading = false
    }
    
    var body: some View {
        if showLoading {
            VStack(alignment: .center) {
                ProgressView()
            }
        } else {
            VStack(alignment: .leading, spacing: 16.0) {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 36.0, alignment: .center)

                Text("Olá")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.accent)

                Text("Preencha para acessar sua conta")
                    .font(.title3)
                    .foregroundStyle(.gray)
                    .padding(.bottom)

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
                    .textInputAutocapitalization(.never)

                Text("Senha")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)

                SecureField("Insira sua senha", text: $password)
                    .padding(14.0)
                    .background(Color.gray.opacity(0.25))
                    .cornerRadius(14.0)
                
                Button (action: {
                    showLoading = true
                    Task {
                        await loginPatient()
                    }
                }, label: {
                    ButtonView(text: "Entrar")
                })
                
                NavigationLink {
                    SignUpView()
                } label: {
                    Text("Ainda não possui conta? Cadastre-se.")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .padding()
            .navigationBarBackButtonHidden()
            .alert("Ops, deu algo errado!", isPresented: $showAlert) {
                Button(action: {
                    //
                }, label: {
                    Text("OK")
                })
            } message: {
                Text("Houve um erro ao logar o paciente. Por favor, tente novamente.")
            }
        }
    }
}

#Preview {
    SignInView()
}
