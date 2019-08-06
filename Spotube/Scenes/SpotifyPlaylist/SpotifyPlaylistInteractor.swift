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
    
    var name: String { get set }
    
    var tokenId: String { get set }
    
    var userId: String { get set }
    
    func showGreeting()
    
    func playListSpotify()
    
}

protocol SpotifyPlaylistWorkerDelegate: class {
    
    func spotifyPlayList(itens: SpotifyPlaylist?)
}

class SpotifyPlaylistInteractor: SpotifyPlaylistBusinessLogic {

    var name: String = ""

    var tokenId: String = ""
    
    var userId: String = ""
    
    var worker: SpotifyPlaylistWorkerProtocol?
    
    var presenter: SpotifyPlaylistPresentationLogic?
    
    let pagination = PaginationWorker()
    
    var faltam: Int = 0
    
    func playListSpotify() {
        let request = Playlist.FetchPlayList.Request(token: tokenId, userId: userId)
        worker?.spotifyRequestList(request: request, pagination: pagination)
    }
    
    func showGreeting() {
        let response = Playlist.ShowHello.Response(name: name)
        presenter?.showHello(response: response)
    }
    
}

extension SpotifyPlaylistInteractor: SpotifyPlaylistWorkerDelegate {
    
    func spotifyPlayList(itens: SpotifyPlaylist?) {
        
        pagination.pagNext = itens?.next
        
        let response = Playlist.FetchPlayList.Response(playlist: itens)
        presenter?.presentFetchedPlaylist(response: response)
    }
    
}
