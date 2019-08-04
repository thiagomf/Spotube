//
//  SpotifyLoginModels.swift
//  Spotube
//
//  Created by Thiago M Faria on 31/07/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

enum SpotifyLogin
{
    // MARK: Use cases
    
    enum FetchUser
    {
        struct Request
        {
        }
        
        struct Response
        {
            var user: SpotifyUser?
            var token: String?
        }
        
        struct ViewModel
        {
            struct DisplayedUser
            {
                var id: String
                var displayName: String
                var image: String
                var token: String
            }
            
            var displayedUser: DisplayedUser
        }
    }
}
