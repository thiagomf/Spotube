//
//  User.swift
//  Spotube
//
//  Created by Thiago M Faria on 01/08/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import Foundation

// MARK: - User
struct User: Codable {
    let country, displayName, email: String
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let images: [Image]
    let product, type, uri: String
    
    enum CodingKeys: String, CodingKey {
        case country
        case displayName = "display_name"
        case email
        case externalUrls = "external_urls"
        case href, id, images, product, type, uri
    }
}

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: String
}

// MARK: - Image
struct Image: Codable {
    let url: String
}
