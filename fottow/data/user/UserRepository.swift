//
//  UserRepository.swift
//  fottow
//
//  Created by Rober on 15/9/25.
//

import Foundation

class UserRepository {
    
    func login(userName: String, password: String, fcm: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        
        // 1. URL del endpoint
        guard let url = URL(string: "https://api-dev.fottow.com/auth/login") else {
            return
        }
        
        // 2. Request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // 3. Body en JSON
        let loginData = LoginRequest(userName: userName, password: password, fcm: fcm)
        
        do {
            let jsonData = try JSONEncoder().encode(loginData)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        // 4. Llamada a la API
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                completion(.success(loginResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
