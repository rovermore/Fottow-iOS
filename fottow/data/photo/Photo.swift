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
