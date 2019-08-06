//
//  SpotifyTracklistModels.swift
//  Spotube
//
//  Created by Thiago M Faria on 05/08/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

enum Tracklist
{
    // MARK: Use cases
    
    enum FetchTrackList
    {
        struct Request
        {
            var token: String
            var playlistId: String
        }
        
        struct Response
        {
            var tracklist: SpotifyTracklist?
        }
        
        struct ViewModel
        {
            
            struct DisplayedTrackList
            {
                var songName: String
                var artistName: String
                var albumName: String
                var albumImage: String
            }
            
            var displayedTracklist: [DisplayedTrackList]
        }
    }
    
    enum PlayListName
    {
        struct Request
        {
        }
        struct Response
        {
            var name: String
        }
        struct ViewModel
        {
            var listName: String
        }
    }
}
