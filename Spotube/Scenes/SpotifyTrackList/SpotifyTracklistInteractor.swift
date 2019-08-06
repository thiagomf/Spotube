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
    
    func trackListSpotify(request: Tracklist.FetchTrackList.Request)
}

protocol SpotifyTracklistWorkerDelegate: class {
    
    func spotifyTrackList(itens: SpotifyTracklist?)
}

class SpotifyTracklistInteractor: SpotifyTracklistBusinessLogic {
    var worker: SpotifyTracklistWorkerProtocol?
    
    var presenter: SpotifyTracklistPresentationLogic?
    
    func trackListSpotify(request: Tracklist.FetchTrackList.Request) {
        
    }
    

}

extension SpotifyTracklistInteractor: SpotifyTracklistWorkerDelegate {
    
    func spotifyTrackList(itens: SpotifyTracklist?) {
        
    }
    
}
