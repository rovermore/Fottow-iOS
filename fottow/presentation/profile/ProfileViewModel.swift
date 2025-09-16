//
//  ProfileViewModel.swift
//  fottow
//
//  Created by Rober on 16/9/25.
//
import Foundation
import Observation

@Observable
final class ProfileViewModel {
    
    let repository: UserRepository
    
    var user: User? = nil
    
    init(repository: UserRepository = UserRepository()) {
        self.repository = repository
    }
    
    func getUser() {
        self.user = repository.getUser()
    }
}
