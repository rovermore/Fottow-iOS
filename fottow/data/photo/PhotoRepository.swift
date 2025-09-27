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
    
    // Ejemplo en tu clase APIService o similar
    func uploadIdentificationSelfie(imageData: Data, filename: String = "photo.jpg") async throws -> UploadPhotoResponse {
        
        print("1. Preparando la URL y la Request...")
        let url = URL(string: FOTTOW_URL + UPLOAD_IDENTIFICATION_ENDPOINT)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Genera el Boundary (separador único para el formulario)
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        print("1. Crear el Body de la petición")
        var body = Data()

        print("2. Agregar la parte de la imagen")
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        // Content-Disposition indica que es un archivo con nombre "file" y nombre de archivo "photo.jpg"
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData) // Agrega los datos binarios de la imagen

        print("3. Finalizar el Body")
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body
        
        print("4. Realizar la llamada")
        let (data, response) = try await URLSession.shared.data(for: request)
        // ... Manejo de la respuesta y decodificación ...
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        // Asume que tienes un modelo 'UploadResponse'
        let uploadResponse = try JSONDecoder().decode(UploadPhotoResponse.self, from: data)
        return uploadResponse
    }
    
    func uploadImage(imageData: Data, filename: String = "photo.jpg") async throws -> UploadPhotoResponse {
        
        print("1. Preparando la URL y la Request...")
        let url = URL(string: FOTTOW_URL + UPLOAD_IMAGE_ENDPOINT)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Genera el Boundary (separador único para el formulario)
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        print("1. Crear el Body de la petición")
        var body = Data()

        print("2. Agregar la parte de la imagen")
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        // Content-Disposition indica que es un archivo con nombre "file" y nombre de archivo "photo.jpg"
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData) // Agrega los datos binarios de la imagen

        print("3. Finalizar el Body")
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body
        
        print("4. Realizar la llamada")
        let (data, response) = try await URLSession.shared.data(for: request)
        // ... Manejo de la respuesta y decodificación ...
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        // Asume que tienes un modelo 'UploadResponse'
        let uploadResponse = try JSONDecoder().decode(UploadPhotoResponse.self, from: data)
        return uploadResponse
    }
}
