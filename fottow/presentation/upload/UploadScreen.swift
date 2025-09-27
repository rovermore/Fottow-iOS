//
//  UploadScreen.swift
//  fottow
//
//  Created by Rober on 27/9/25.
//

import SwiftUI

struct UploadScreen: View {
    @State private var viewModel = UploadViewModel()
        

    @State private var selectedImage: UIImage? = nil
    @State private var isShowingCamera = false
    @State private var isShowingGallery = false
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Text("Solo sube la foto, nosotros la distribuiremos entre los protagonistas")
                
                if let image = selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 200)
                            } else {
                                Text("Selecciona o captura una imagen")
                            }
                            
                // Botón 1: Abre la CÁMARA
                Button("Abrir Cámara") {
                    isShowingCamera = true
                }
                .buttonStyle(.borderedProminent)

                // Botón 2: Abre la GALERÍA
                Button("Seleccionar de Galería") {
                    isShowingGallery = true
                }
                .buttonStyle(.bordered)
                
                Button("Subir Imagen") {
                    viewModel.uploadImage()
                }
                .buttonStyle(.borderedProminent)
            }
        }.padding()
        .navigationBarTitle("Upload")
        .fullScreenCover(isPresented: $viewModel.isShowingCamera) {
                    ImagePicker(selectedImage: $viewModel.capturedImage, sourceType: .camera)
                }
                
        // Modal para la Galería (el nuevo selector)
        .sheet(isPresented: $isShowingGallery) {
                    // 🚨 CAMBIO CLAVE: Usamos .photoLibrary como sourceType
                    // Usamos .sheet para la galería, que es el estilo estándar de iOS
                    ImagePicker(selectedImage: $viewModel.capturedImage, sourceType: .photoLibrary)
                }
    }
}

#Preview {
    UploadScreen()
}
