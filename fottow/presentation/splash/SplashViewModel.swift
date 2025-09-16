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
    
    // Esta propiedad ahora es observable
    var isUserLogged: Bool = false
    
    init(repository: UserRepository = UserRepository()) {
        self.repository = repository
        self.checkLogin()
    }
    
    func checkLogin() {
        self.isUserLogged = repository.isUserLoggedIn()
    }
}
