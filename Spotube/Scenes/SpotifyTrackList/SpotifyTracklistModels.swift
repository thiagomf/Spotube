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
                var name: String
                var image: String
                var id: String
                var owner: String
            }
            
            var displayedPlaylist: [DisplayedTrackList]
        }
    }
}
