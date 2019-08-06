//
//  SpotifyTracklistWorker.swift
//  Spotube
//
//  Created by Thiago M Faria on 05/08/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

protocol SpotifyTracklistWorkerProtocol: class {
    
    var remoteDataManager: SpotifyTracklistAPIInputProtocol? { get set }
    
    var interactor: SpotifyTracklistWorkerDelegate? { get set }
    
    func spotifyRequestList(request: Tracklist.FetchTrackList.Request)
    
}

protocol SpotifyTracklistOutputProtocol: class {
    
    func fetchTrackListSpotify(itens: SpotifyTracklist?)
    
}

class SpotifyTracklistWorker: SpotifyTracklistWorkerProtocol {
    
    var remoteDataManager: SpotifyTracklistAPIInputProtocol?
    
    var interactor: SpotifyTracklistWorkerDelegate?
    
    func spotifyRequestList(request: Tracklist.FetchTrackList.Request) {
        remoteDataManager?.callAPITracklist(request: request)
    }
}

extension SpotifyTracklistWorker: SpotifyTracklistOutputProtocol {
    
    func fetchTrackListSpotify(itens: SpotifyTracklist?) {
        interactor?.spotifyTrackList(itens: itens)
    }
}
