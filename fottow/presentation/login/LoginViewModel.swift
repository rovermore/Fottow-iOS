//
//  LoginViewModel.swift
//  fottow
//
//  Created by Rober on 15/9/25.
//
import SwiftUI

@Observable
final class LoginViewModel {
    var repository = UserRepository()
    
    init(repository: UserRepository = UserRepository()) {
        self.repository = repository
    }

    func login(userName: String, password: String, fcm: String){
        repository.login(userName: userName, password: password, fcm: fcm) { result in
            switch result {
            case .success(let response):
                print("Token: \(response.token)")
                guard let user = response.user else { return }
                print("Usuario: \(user.userName)")
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
