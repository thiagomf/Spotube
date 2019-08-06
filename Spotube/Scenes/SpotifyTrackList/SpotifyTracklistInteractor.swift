//
//  SpotifyTracklistInteractor.swift
//  Spotube
//
//  Created by Thiago M Faria on 05/08/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

protocol SpotifyTracklistBusinessLogic: class {
    
    var worker: SpotifyTracklistWorkerProtocol? { get set }
    
    var presenter: SpotifyTracklistPresentationLogic? { get set }
    
    var token: String { get set }
    
    var playlistId: String { get set }
    
    func trackListSpotify(request: Tracklist.FetchTrackList.Request)
}

protocol SpotifyTracklistWorkerDelegate: class {
    
    func spotifyTrackList(itens: SpotifyTracklist?)
}

class SpotifyTracklistInteractor: SpotifyTracklistBusinessLogic {
    
    var worker: SpotifyTracklistWorkerProtocol?
    
    var presenter: SpotifyTracklistPresentationLogic?
    
    var token: String = ""
    
    var playlistId: String = ""
    
    func trackListSpotify(request: Tracklist.FetchTrackList.Request) {
        worker?.spotifyRequestList(request: request)
    }
}

extension SpotifyTracklistInteractor: SpotifyTracklistWorkerDelegate {
    
    func spotifyTrackList(itens: SpotifyTracklist?) {
        
    }
    
}
