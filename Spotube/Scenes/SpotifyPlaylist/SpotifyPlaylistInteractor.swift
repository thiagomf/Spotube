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
    
    let pagination = PaginationWorker()
    
    var faltam: Int = 0
    
    func playListSpotify(request: Playlist.FetchPlayList.Request) {

        worker?.spotifyRequestList(request: request, pagination: pagination)
        
    }
}

extension SpotifyPlaylistInteractor: SpotifyPlaylistWorkerDelegate {
    
    func spotifyPlayList(itens: SpotifyPlaylist?) {
        
        pagination.pagNext = itens?.next
        
        let reponse = Playlist.FetchPlayList.Response.init(playlist: itens)
        presenter?.presentFetchedPlaylist(response: reponse)
    }
    
}
