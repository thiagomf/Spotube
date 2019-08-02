//
//  SpotifyLoginInteractor.swift
//  Spotube
//
//  Created by Thiago M Faria on 31/07/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

protocol SotifyLoginBusinessLogic {
    
    var presenter: SpotifyLoginPresentationLogic? { get set }
    
    func fetchLoginUser(request: SpotifyLogin.FetchUser.Request)
}

class SpotifyLoginInteractor: NSObject, SotifyLoginBusinessLogic {
    
    var presenter: SpotifyLoginPresentationLogic?
    
    var spotifyLoginWorker = SpotifyLoginWorker()
    
    func fetchLoginUser(request: SpotifyLogin.FetchUser.Request) {
        spotifyLoginWorker.worker = self
        spotifyLoginWorker.fetchLoginSpotify(request: request)
    }
}

extension SpotifyLoginInteractor: SpotifyLoginWorkerDelegate {
    
    func spotifyLogger(user: User?) {
        
        if let userSpotify = user {
            let response = SpotifyLogin.FetchUser.Response(user: userSpotify)
            presenter?.presentFetchedUser(response: response)
        } else {
            presenter?.presentNilUser()
        }
    }
    
}
