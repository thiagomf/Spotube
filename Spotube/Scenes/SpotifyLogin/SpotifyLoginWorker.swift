//
//  SpotifyLoginWorker.swift
//  Spotube
//
//  Created by Thiago M Faria on 31/07/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

protocol SpotifyLoginWorkerProtocol: class {
    
    var remoteDataManager: SpotifyLoginAPIInputProtocol? { get set }
    
    var interactor: SpotifyLoginWorkerDelegate? { get set }
    
    func spotifyRequestLogin()
    
    func disconnectSpotify()
    
    func spotifySetApplication(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
    
    func connectSpotify()
}

protocol SpotifyLoginOutputProtocol: class {
    
    func tokenAcess(token: String)
    
    func fetchUserSpotify(user: SpotifyUser?, token: String)
}

class SpotifyLoginWorker: SpotifyLoginWorkerProtocol {

    var remoteDataManager: SpotifyLoginAPIInputProtocol?
    
    var interactor: SpotifyLoginWorkerDelegate?
    
    func spotifyRequestLogin() {
        remoteDataManager?.callRequestLogin()
    }
    
    func disconnectSpotify() {
        remoteDataManager?.disconectSpotify()
    }
    
    func spotifySetApplication(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) {
        remoteDataManager?.spotifyApplication(app: app, open: url, options: options)
    }
    
    func connectSpotify() {
        remoteDataManager?.reConnectSpotify()
    }
}

extension SpotifyLoginWorker: SpotifyLoginOutputProtocol {
    
    func tokenAcess(token: String) {
        remoteDataManager?.callAPILogin(token: token)
    }

    
    func fetchUserSpotify(user: SpotifyUser?, token: String) {
        interactor?.spotifyLogger(user: user, token: token)
    }
}
