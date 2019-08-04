//
//  SpotifyPlaylistInteractor.swift
//  Spotube
//
//  Created by Thiago M Faria on 02/08/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

protocol SpotifyPlaylistBusinessLogic: class {
    
    var worker: SpotifyPlaylistWorkerProtocol? { get set }
    
    var presenter: SpotifyPlaylistPresentationLogic? { get set }
    
    func playListSpotify(request: Playlist.FetchPlayList.Request)
}

protocol SpotifyPlaylistWorkerDelegate: class {
    
    func spotifyPlayList(itens: SpotifyPlaylist?)
}

class SpotifyPlaylistInteractor: SpotifyPlaylistBusinessLogic {
    
    var worker: SpotifyPlaylistWorkerProtocol?
    
    var presenter: SpotifyPlaylistPresentationLogic?
    
    func playListSpotify(request: Playlist.FetchPlayList.Request) {
        worker?.spotifyRequestList(request: request)
    }

}

extension SpotifyPlaylistInteractor: SpotifyPlaylistWorkerDelegate {
    
    func spotifyPlayList(itens: SpotifyPlaylist?) {
        let reponse = Playlist.FetchPlayList.Response.init(playlist: itens)
        presenter?.presentFetchedPlaylist(response: reponse)
    }
    
}
