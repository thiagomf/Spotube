//
//  Playlist.swift
//  Spotube
//
//  Created by Thiago M Faria on 01/08/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import Foundation

// MARK: - Playlist
struct SpotifyPlaylist: Codable {
    let href: String
    let items: [Item]
    let limit: Int
    let next: String
    let offset: Int
    let total: Int
}

// MARK: - Item
struct Item: Codable {
    let collaborative: Bool
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let images: [Image]
    let name: String
    let owner: Owner
    let itemPublic: Bool
    let snapshotID: String
    let tracks: Tracks
    let type, uri: String
    
    enum CodingKeys: String, CodingKey {
        case collaborative
        case externalUrls = "external_urls"
        case href, id, images, name, owner
        case itemPublic = "public"
        case snapshotID = "snapshot_id"
        case tracks, type, uri
    }
}

// MARK: - Owner
struct Owner: Codable {
    let displayName: String
    let externalUrls: ExternalUrls
    let href: String
    let id, type, uri: String
    
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case externalUrls = "external_urls"
        case href, id, type, uri
    }
}

// MARK: - Tracks
struct Tracks: Codable {
    let href: String
    let total: Int
}
