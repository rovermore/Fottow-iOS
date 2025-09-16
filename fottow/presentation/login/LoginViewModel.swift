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
                }
                // Aquí puedes actualizar propiedades `@Published` para refrescar la UI
                } catch {
                    // Se ejecuta si hay un error (red, decodificación, etc.)
                    print("Error en el login: \(error.localizedDescription)")
                    // Aquí puedes actualizar una propiedad para mostrar un mensaje de error en la UI
                }
            }
    }
}
