//
//  PhotoRepository.swift
//  fottow
//
//  Created by Rober on 16/9/25.
//

import Foundation

class PhotoRepository {
    
    func getPhotos() async throws -> [Photo] {
        
        print("1. Preparando la URL y la Request...")
        guard let url = URL(string: FOTTOW_URL + PHOTOS_ENDPOINT) else {
            print("Error: URL inválida.")
            throw URLError(.badURL)
        }
                
        let token = UserDefaults.standard.string(forKey: TOKEN_KEY) ?? ""
        print("2. Token: \(token)")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        
        print("3. Enviando la petición de FOTOS a la API...")
        let (data, response) = try await URLSession.shared.data(for: request)
        
        print("4. Petición recibida. Verificando el código de respuesta HTTP...")
        guard let httpResponse = response as? HTTPURLResponse else {
            print("ErrorPhoto: La respuesta no es una respuesta HTTP.")
            throw URLError(.badServerResponse)
        }
        
        // Aquí es donde se maneja el error -1011 (NSURLErrorBadServerResponse)
        guard (200...299).contains(httpResponse.statusCode) else {
            print("ErrorPhoto: Código de estado HTTP no exitoso -> \(httpResponse.statusCode)")
            throw URLError(.badServerResponse) // Lanza el error capturado por el ViewModel
        }
        
        print("5. Código de respuesta exitoso (\(httpResponse.statusCode)). Decodificando los datos (fotos)...")
        let photoResponse = try JSONDecoder().decode(PhotoResponse.self, from: data)
        
        
        print("6. Decodificación exitosa. Fotos extraidas correctamente.")
        return photoResponse.images
    }
}
