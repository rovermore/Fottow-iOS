//
//  Photo.swift
//  fottow
//
//  Created by Rober on 16/9/25.
//

struct Photo: Codable, Hashable {
    let url: String
    let date: String
    let own: Bool
}

struct PhotoResponse: Codable {
    let images: [Photo]
}

struct UploadPhotoResponse: Codable {
    let message: String
    let imageUrl: String
    let totalFaces: Int
    
    private enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case message
        case totalFaces = "total_faces"
    }
}
