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
            var token: String
        }
        
        struct Response
        {
            var user: User?
        }
        
        struct ViewModel
        {
            struct DisplayedUser
            {
                var country: String
                var displayName: String
                var email: String
                var image: String
            }
            
            var displayedUser: DisplayedUser
        }
    }
}
