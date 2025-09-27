//
//  ImagePicker.swift
//  fottow
//
//  Created by Rober on 27/9/25.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage? // 1. Imagen capturada por el usuario
    @Environment(\.dismiss) var dismiss // Para cerrar la cámara
    
    // Define el tipo de controlador de vista que estás envolviendo
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        // Configura el picker para usar la cámara
        picker.sourceType = .camera
        // Asigna el coordinador para manejar los eventos del delegado
        picker.delegate = context.coordinator
        return picker
    }

    // Método requerido para actualizar la vista (no se usa aquí)
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    // Crea el objeto delegado (Coordinador)
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // Clase Coordinadora para manejar los eventos del UIImagePickerController
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        // Se llama cuando el usuario toma y acepta una foto
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            // Obtiene la imagen original capturada
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }
            // Cierra la vista de la cámara
            parent.dismiss()
        }

        // Se llama si el usuario cancela
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}
