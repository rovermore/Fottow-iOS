//
//  SplashViewModel.swift
//  fottow
//
//  Created by Rober on 16/9/25.
//

import Foundation
import Observation // Importar el framework Observation

@Observable
final class SplashViewModel {
    
    let repository: UserRepository
    
    var appState: AppState = .loggedOut
    
    init(repository: UserRepository = UserRepository()) {
        self.repository = repository
        self.checkLogin()
    }
    
    func checkLogin() {
        if repository.isUserLoggedIn() {
                    self.appState = .loggedIn
                } else {
                    self.appState = .loggedOut
                }
    }
}

enum AppState {
    case loggedIn
    case loggedOut
}
