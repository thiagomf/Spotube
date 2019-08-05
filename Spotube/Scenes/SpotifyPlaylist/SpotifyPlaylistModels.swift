//
//  SpotifyPlaylistModels.swift
//  Spotube
//
//  Created by Thiago M Faria on 02/08/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

enum Playlist
{
    // MARK: Use cases
    
    enum FetchPlayList
    {
        struct Request
        {
            var token: String
            var userId: String
        }
        
        struct Response
        {
            var playlist: SpotifyPlaylist?
        }
        
        struct ViewModel
        {
            struct DisplayedPlayList
            {
                var name: String
                var image: String
                var id: String
                var owner: String
            }
            
            var displayedPlaylist: [DisplayedPlayList]
        }
    }
}
