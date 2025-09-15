//
//  LoginScreen.swift
//  fottow
//
//  Created by Rober on 14/9/25.
//
import SwiftUI


struct LoginScreen: View {
    @State private var viewModel = LoginViewModel()
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
                
                Text("Inicia Sesión")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
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
                
                PrimaryButton(text: "Iniciar sesión") {
                    viewModel.login(userName: email, password: password, fcm: "lfrsdvheiluhslvusi")
                }
                
                NavigationLink(destination: RegisterScreen()) {
                    Text("Crear cuenta")
                        .bold()
                }
                
            }
            .padding()
            
        }
    }
}

#Preview {
    LoginScreen()
}
