//
//  GalleryViewModel.swift
//  fottow
//
//  Created by Rober on 16/9/25.
//

import SwiftUI

@Observable
final class GalleryViewModel {
    
    let repository: PhotoRepository
    
    var photos: [Photo] = []
    var showError: Bool = false
    var errorMessage: String?
    
    init(repository: PhotoRepository = PhotoRepository()) {
        self.repository = repository
    }
        
    func getPhotos() {
        Task { @MainActor in
            do {
                let response = try await repository.getPhotos()
                self.photos = response
                } catch {
                    print("Error al traer fotos: \(error.localizedDescription)")
                    self.showError = true
                    self.errorMessage = error.localizedDescription
                }
            }
    }

}
