//
//  User.swift
//  Spotube
//
//  Created by Thiago M Faria on 01/08/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//
import Foundation

// MARK: - User
struct SpotifyUser: Codable {
    let displayName: String
    let externalUrls: ExternalUrls
    let followers: Followers
    let href: String
    let id: String
    let images: [Image]
    let type, uri: String
    
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case externalUrls = "external_urls"
        case followers, href, id, images, type, uri
    }
}

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: String
}

// MARK: - Followers
struct Followers: Codable {
    let total: Int
}

// MARK: - Image
struct Image: Codable {
    let url: String
}



