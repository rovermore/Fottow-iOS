//
//  IdentificationScreen.swift
//  fottow
//
//  Created by Rober on 17/9/25.
//

import SwiftUI

struct IdentificationScreen: View {
    @State private var viewModel = IdentificationViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 40)  {
                Text("Mándanos un selfie para identificarte")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Con este selfie crearemos un patrón seguro de tu rostro. Recuerda que solo utilizamos esta foto para generar el patrón vectorial que nos permitirá identificarte y que recibas cada foto en la que aparezcas subida a la plataforma.")
                
                // Muestra la imagen si ha sido capturada
                            if let image = viewModel.capturedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 300)
                            } else {
                                Text("Presiona el botón para abrir la cámara.")
                                    .foregroundColor(.gray)
                            }
                            
                            // Botón para abrir la cámara
                            Button("Abrir Cámara") {
                                // Alterna el estado para mostrar el ImagePicker
                                viewModel.isShowingCamera = true
                            }
                            .buttonStyle(.borderedProminent)
                            
                            // Botón para subir la foto (solo si hay imagen)
                            if viewModel.capturedImage != nil {
                                Button {
                                    viewModel.uploadPhoto()
                                } label: {
                                    if viewModel.isLoading {
                                        ProgressView()
                                    } else {
                                        Text("Subir Foto")
                                    }
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(.green)
                                .disabled(viewModel.isLoading)
                            }
                    
                }
            }.padding()
        // Muestra el ImagePicker como una presentación modal
                .fullScreenCover(isPresented: $viewModel.isShowingCamera) {
                    ImagePicker(selectedImage: $viewModel.capturedImage)
                }
                // Muestra el error si existe
                .alert("Error de Carga", isPresented: .constant(viewModel.uploadError != nil), actions: {
                    Button("OK", role: .cancel) { viewModel.uploadError = nil }
                }, message: {
                    Text(viewModel.uploadError?.localizedDescription ?? "Algo salió mal.")
                })
                .onChange(of: viewModel.capturedImage) { _ in
                    // Opcional: Ejecutar la subida automáticamente después de la captura
                    // viewModel.uploadPhoto()
                }
            
        }
    
}

#Preview {
    IdentificationScreen()
}
