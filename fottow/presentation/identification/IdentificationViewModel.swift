//
//  IdentificationViewModel.swift
//  fottow
//
//  Created by Rober on 27/9/25.
//

//
//  UploadViewModel.swift
//  fottow
//
//  Created by Rober on 27/9/25.
//

import UIKit
import Observation

@Observable
class IdentificationViewModel {
    
    var capturedImage: UIImage?
    
    var isShowingCamera = false
    
    var isLoading = false
    var uploadError: Error?
    
    let repository: PhotoRepository
    
    init(repository: PhotoRepository = PhotoRepository()) {
        self.repository = repository
    }
    
    func uploadIdentificationImage() {
        guard let image = capturedImage else {
            print("Error: No hay imagen para subir.")
            return
        }
        
        // Convertir la imagen a Data (ej. JPEG)
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Error: No se pudo convertir la imagen a Data.")
            return
        }
        
        self.isLoading = true
        self.uploadError = nil
        
        Task { @MainActor in
            do {
                let response = try await repository.uploadIdentificationSelfie(imageData: imageData)
                
                print("Imagen subida con éxito.")
                self.isLoading = false
                self.capturedImage = nil // Limpia la imagen después de subir
            } catch {
                self.uploadError = error
                self.isLoading = false
                print("Fallo al subir la imagen: \(error)")
            }
        }
        
    }
}
