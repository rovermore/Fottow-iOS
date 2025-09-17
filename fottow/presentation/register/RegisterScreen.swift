//
//  RegisterScreen.swift
//  fottow
//
//  Created by Rober on 15/9/25.
//

import SwiftUI

struct RegisterScreen: View {
    @State private var viewModel = RegisterViewModel()
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.tint)
                
                Text("Regístrate")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                TextField("Nombre", text: $email)
                    .frame(maxWidth: .infinity, minHeight:40)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                
                TextField("Email", text: $email)
                    .frame(maxWidth: .infinity, minHeight:40)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                
                SecureField("Password", text: $password)
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled(true)
                
                PrimaryButton(text: "Crear cuenta") { }
                
            }
            .padding()
            .navigationDestination(isPresented: $viewModel.isRegistered) {
                IdentificationScreen()
            }
            .alert("Error",
                   isPresented: $viewModel.showError,
                   actions: {
                       Button("OK", role: .cancel) { }
                   },
                   message: {
                       Text(viewModel.errorMessage ?? "Error desconocido")
                   }
            )
        }
    }
}

#Preview {
    RegisterScreen()
}
