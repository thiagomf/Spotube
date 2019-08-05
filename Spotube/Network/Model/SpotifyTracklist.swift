//
//  SpotifyTracklist.swift
//  Spotube
//
//  Created by Thiago M Faria on 05/08/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

class SpotifyTracklist: Codable {
    let href: String
    let items: [TrackItem]
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int

}

// MARK: - Item
struct TrackItem: Codable {
    let addedAt: Date
    let addedBy: AddedBy
    let isLocal: Bool
    let primaryColor: String?
    let track: Track
    
    enum CodingKeys: String, CodingKey {
        case addedAt = "added_at"
        case addedBy = "added_by"
        case isLocal = "is_local"
        case primaryColor = "primary_color"
        case track
    }
}

// MARK: - AddedBy
struct AddedBy: Codable {
    let href: String
    let id: String
    let type: AddedByType
    let uri: String
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case href, id, type, uri, name
    }
}

enum AddedByType: String, Codable {
    case artist = "artist"
    case user = "user"
}

// MARK: - Track
struct Track: Codable {
    let album: Album
    let artists: [AddedBy]
    let availableMarkets: [String]
    let discNumber, durationMS: Int
    let episode, explicit: Bool
    let externalIDS: ExternalIDS
    let href: String
    let id: String
    let isLocal: Bool
    let name: String
    let popularity: Int
    let previewURL: String?
    let track: Bool
    let trackNumber: Int
    let type: TrackType
    let uri: String
    
    enum CodingKeys: String, CodingKey {
        case album, artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case episode, explicit
        case externalIDS = "external_ids"
        case href, id
        case isLocal = "is_local"
        case name, popularity
        case previewURL = "preview_url"
        case track
        case trackNumber = "track_number"
        case type, uri
    }
}

// MARK: - Album
struct Album: Codable {
    let albumType: AlbumTypeEnum
    let artists: [AddedBy]
    let availableMarkets: [String]
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let images: [Image]
    let name, releaseDate: String
    let releaseDatePrecision: ReleaseDatePrecision
    let totalTracks: Int
    let type: AlbumTypeEnum
    let uri: String
    
    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case artists
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case totalTracks = "total_tracks"
        case type, uri
    }
}

enum AlbumTypeEnum: String, Codable {
    case album = "album"
    case single = "single"
}

enum ReleaseDatePrecision: String, Codable {
    case day = "day"
}

// MARK: - ExternalIDS
struct ExternalIDS: Codable {
    let isrc: String
}

enum TrackType: String, Codable {
    case track = "track"
}
