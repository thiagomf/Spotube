//
//  SpotifyLoginWorker.swift
//  Spotube
//
//  Created by Thiago M Faria on 31/07/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

protocol SpotifyLoginWorkerDelegate
{
    func spotifyLogger(user: User?)
}

class SpotifyLoginWorker: NSObject, SpotifyLoginOutputProtocol {

    var spotifyLoginAPI: SpotifyLoginAPIInputProtocol = SpotifyLoginAPI()
    var worker: SpotifyLoginWorkerDelegate?
    
    func fetchLoginSpotify(request: SpotifyLogin.FetchUser.Request) {
        spotifyLoginAPI.remoteRequestHandler = self
        spotifyLoginAPI.callAPILogin(request: request)
    }
    
    func fetchUserSpotify(user: User?) {
        worker?.spotifyLogger(user: user)
    }
}
