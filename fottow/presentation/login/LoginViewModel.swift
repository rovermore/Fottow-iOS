//
//  LoginViewModel.swift
//  fottow
//
//  Created by Rober on 15/9/25.
//
import SwiftUI

@Observable
final class LoginViewModel {
    let repository: UserRepository
    
    var isLoggedIn: Bool = false
    var showError: Bool = false
    var errorMessage: String?
    
    init(repository: UserRepository = UserRepository()) {
        self.repository = repository
    }

    func login(userName: String, password: String, fcm: String){
        Task { @MainActor in
            do {
                let response = try await repository.login(userName: userName, password: password, fcm: fcm)
                // Se ejecuta si la llamada es exitosa
                print("Token: \(String(describing: response.token))")
                if let user = response.user {
                    print("Usuario: \(user.userName)")
                    self.isLoggedIn = true
                }
                } catch {
                    print("Error en el login: \(error.localizedDescription)")
                    self.showError = true
                    self.errorMessage = error.localizedDescription
                    self.isLoggedIn = false
                }
            }
    }
}
