//
//  RegisterViewModel.swift
//  fottow
//
//  Created by Rober on 17/9/25.
//
import SwiftUI

@Observable
final class RegisterViewModel {
    let repository: UserRepository
    
    var isRegistered: Bool = false
    var showError: Bool = false
    var errorMessage: String?
    
    init(repository: UserRepository = UserRepository()) {
        self.repository = repository
    }
    
    func register(userName: String, password: String, nickname: String) {
        Task { @MainActor in
            do {
                try await repository.registerUser(userName: userName, password: password, nickname: nickname)
                self.isRegistered = true
            } catch {
                print("Error en el registro: \(error.localizedDescription)")
                self.showError = true
                self.errorMessage = error.localizedDescription
            }
            
        }
    }
    
}
