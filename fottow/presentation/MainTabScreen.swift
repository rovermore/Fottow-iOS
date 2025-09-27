//
//  MainTabScreen.swift
//  fottow
//
//  Created by Rober on 16/9/25.
//

import SwiftUI

// La vista principal que contendrá la TabView
struct MainTabScreen: View {
    
    var body: some View {
        TabView {
            // Primera pestaña: Galería de Fotos
            NavigationStack { // Importante para la navegación interna de cada pestaña
                GalleryScreen() // Pasar el ViewModel
            }
            .tabItem {
                Label("Fotos", systemImage: "photo.fill")
            }
            
            // Segunda pestaña: Perfil del Usuario
            NavigationStack {
                UploadScreen()
            }
            .tabItem {
                Label("Subir", systemImage: "plus")
            }
            
            // Segunda pestaña: Perfil del Usuario
            NavigationStack {
                ProfileScreen()
            }
            .tabItem {
                Label("Perfil", systemImage: "person.fill")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MainTabScreen()
}
