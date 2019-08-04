//
//  SpotifyLoginInteractor.swift
//  Spotube
//
//  Created by Thiago M Faria on 31/07/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

protocol SpotifyLoginBusinessLogic: class {
    
    var worker: SpotifyLoginWorkerProtocol? { get set }
    
    var presenter: SpotifyLoginPresentationLogic? { get set }
    
    func loginSpotify()
}

protocol SpotifyLoginWorkerDelegate: class {
    
    func spotifyLogger(user: SpotifyUser?, token: String)
}

class SpotifyLoginInteractor: SpotifyLoginBusinessLogic {

    var worker: SpotifyLoginWorkerProtocol?
    
    var presenter: SpotifyLoginPresentationLogic?
    
    func loginSpotify() {
        worker?.spotifyRequestLogin()
    }
}

extension SpotifyLoginInteractor: SpotifyLoginWorkerDelegate {
    
    func spotifyLogger(user: SpotifyUser?, token: String) {
        
        if let userSpotify = user {
            let response = SpotifyLogin.FetchUser.Response(user: userSpotify, token: token)
            presenter?.presentFetchedUser(response: response)
        } else {
            presenter?.presentNilUser()
        }
    }
    
}
