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
        
        saveToken(loginResponse.token)
        
        saveUser(loginResponse.user)
        
        print("6. Decodificación exitosa. Login completado.")
        return loginResponse
    }
    
    func registerUser(userName: String, password: String, nickname: String) async throws -> RegisterResponse {
        print("1. Preparando la URL y la Request del LOGIN...")
        guard let url = URL(string: FOTTOW_URL + REGISTER_ENDPOINT) else {
            print("Error: URL inválida.")
            throw URLError(.badURL)
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("2. Creando el cuerpo de la petición (JSON)...")
        let registerData = RegisterRequest(userName: userName, password: password,nickName: nickname , fcm: "fakefcm")
        let jsonData = try JSONEncoder().encode(registerData)
        request.httpBody = jsonData
        print("Cuerpo de la petición: \(String(data: jsonData, encoding: .utf8) ?? "(no se pudo convertir al string)")")
        
        
        print("3. Enviando la petición de REGISTRO a la API...")
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
        let registerResponse = try JSONDecoder().decode(RegisterResponse.self, from: data)
        
        saveToken(registerResponse.token)
        
        saveUser(User(userName: userName, nick: nickname, profileImage: ""))
        
        print("6. Decodificación exitosa. Login completado.")
        return registerResponse
    }
    
    func isUserLoggedIn() -> Bool {
        let isUseLogged = UserDefaults.standard.string(forKey: TOKEN_KEY) != nil && !UserDefaults.standard.string(forKey: TOKEN_KEY)!.isEmpty
        print("isUseLogged: \(isUseLogged)")
        return isUseLogged
    }
    
    func getUser() -> User? {
        // 1. Obtén el Data de UserDefaults
        guard let userData = UserDefaults.standard.data(forKey: USER_KEY) else {
            return nil // No se encontró el usuario
        }
        
        do {
            // 2. Decodifica el Data a un objeto User
            let user = try JSONDecoder().decode(User.self, from: userData)
            return user
        } catch {
            print("Error al decodificar el usuario: \(error)")
            return nil // Fallo en la decodificación
        }
    }
    
    func saveUser(_ user: User) {
        do {
            // 1. Codifica el objeto User a Data
            let userData = try JSONEncoder().encode(user)
            
            // 2. Guarda el Data en UserDefaults
            UserDefaults.standard.set(userData, forKey: USER_KEY)
            
            print("Usuario guardado correctamente.")
            
        } catch {
            print("Error al codificar el usuario para guardar: \(error)")
        }
    }
    
    func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: TOKEN_KEY)
    }
}
