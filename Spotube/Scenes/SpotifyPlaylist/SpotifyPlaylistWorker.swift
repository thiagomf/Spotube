//
//  SpotifyPlaylistWorker.swift
//  Spotube
//
//  Created by Thiago M Faria on 02/08/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

protocol SpotifyPlaylistWorkerProtocol: class {
    
    var remoteDataManager: SpotifyPlaylistAPIInputProtocol? { get set }
    
    var interactor: SpotifyPlaylistWorkerDelegate? { get set }
    
    func spotifyRequestList(request: Playlist.FetchPlayList.Request)
    
}

protocol SpotifyPlaylistOutputProtocol: class {
    
    func fetchPlayListSpotify(itens: SpotifyPlaylist?)
    
}

class SpotifyPlaylistWorker: SpotifyPlaylistWorkerProtocol {
    
    var remoteDataManager: SpotifyPlaylistAPIInputProtocol?
    
    var interactor: SpotifyPlaylistWorkerDelegate?
    
    func spotifyRequestList(request: Playlist.FetchPlayList.Request) {
        remoteDataManager?.callAPIPlaylist(request: request)
    }
}

extension SpotifyPlaylistWorker: SpotifyPlaylistOutputProtocol {
    
    func fetchPlayListSpotify(itens: SpotifyPlaylist?) {
        interactor?.spotifyPlayList(itens: itens)
    }
}
