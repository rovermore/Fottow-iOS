//
//  GalleryScreen.swift
//  fottow
//
//  Created by Rober on 16/9/25.
//
import SwiftUI

struct GalleryScreen: View {
    @State private var viewModel = GalleryViewModel()

    var body: some View {
        GeometryReader { geometry in
            let itemSize = (geometry.size.width / 4) - (3 * 1) // Calcula el tamaño de la celda
            
            // Define las columnas con un tamaño fijo
            let columns = [
                GridItem(.fixed(itemSize), spacing: 1),
                GridItem(.fixed(itemSize), spacing: 1),
                GridItem(.fixed(itemSize), spacing: 1),
                GridItem(.fixed(itemSize), spacing: 1)
            ]
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 1) {
                    ForEach(viewModel.photos, id: \.self) { photo in
                        AsyncImage(url: URL(string: photo.url)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: itemSize, height: itemSize)
                                    .background(Color.gray.opacity(0.2))
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: itemSize, height: itemSize) // Asegura que la imagen tenga el mismo tamaño
                                    .clipped()
                            case .failure:
                                ProgressView()
                                    .frame(width: itemSize, height: itemSize)
                                    .background(Color.gray.opacity(0.2))
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.getPhotos()
        }
    }
}

#Preview {
    GalleryScreen()
}
