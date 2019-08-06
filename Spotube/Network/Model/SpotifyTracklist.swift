//
//  SpotifyTracklist.swift
//  Spotube
//
//  Created by Thiago M Faria on 05/08/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit
//SpotifyTracklist

// MARK: - TrackList
struct SpotifyTracklist: Codable {
    let items: [TrackItem]
}

// MARK: - Item
struct TrackItem: Codable {
    let track: Track
}

// MARK: - Track
struct Track: Codable {
    let album: Album
    let name: String
    let popularity: Int
}

// MARK: - Album
struct Album: Codable {
    let artists: [Artist]
    let images: [ImageTrack]
    let name: String
}

// MARK: - Artist
struct Artist: Codable {
    let externalUrls: ExternalUrls
    let href: String
    let id, name, type, uri: String
    
    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, id, name, type, uri
    }
}

// MARK: - Image
struct ImageTrack: Codable {
    let height: Int
    let url: String
    let width: Int
}

