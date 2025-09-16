//
//  UserRepository.swift
//  fottow
//
//  Created by Rober on 15/9/25.
//

import Foundation

class UserRepository {
        
    func login(userName: String, password: String, fcm: String) async throws -> LoginResponse {
        
        print("1. Preparando la URL y la Request del LOGIN...")
        guard let url = URL(string: FOTTOW_URL + LOGIN_ENDPOINT) else {
            print("Error: URL inválida.")
            throw URLError(.badURL)
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("2. Creando el cuerpo de la petición (JSON)...")
        let loginData = LoginRequest(userName: userName, password: password, fcm: fcm)
        let jsonData = try JSONEncoder().encode(loginData)
        request.httpBody = jsonData
        print("Cuerpo de la petición: \(String(data: jsonData, encoding: .utf8) ?? "(no se pudo convertir al string)")")
        
        
        print("3. Enviando la petición de LOGIN a la API...")
        let (data, response) = try await URLSession.shared.data(for: request)
        
        print("4. Petición recibida. Verificando el código de respuesta HTTP...")
        guard let httpResponse = response as? HTTPURLResponse else {
            print("ErrorLogin: La respuesta no es una respuesta HTTP.")
            throw URLError(.badServerResponse)
        }
        
        // Aquí es donde se maneja el error -1011 (NSURLErrorBadServerResponse)
        guard (200...299).contains(httpResponse.statusCode) else {
            print("ErrorLogin: Código de estado HTTP no exitoso -> \(httpResponse.statusCode)")
            throw URLError(.badServerResponse) // Lanza el error capturado por el ViewModel
        }
        
        print("5. Código de respuesta exitoso (\(httpResponse.statusCode)). Decodificando los datos...")
        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
        
        UserDefaults.standard.set(loginResponse.token, forKey: TOKEN_KEY)
        
        print("6. Decodificación exitosa. Login completado.")
        return loginResponse
    }
    
    func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.string(forKey: TOKEN_KEY) != nil && !UserDefaults.standard.string(forKey: TOKEN_KEY)!.isEmpty
    }
}
