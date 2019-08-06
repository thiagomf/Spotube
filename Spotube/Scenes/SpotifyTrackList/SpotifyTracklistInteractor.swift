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
    
    var listName: String { get set }
    
    func trackListSpotify()
    
    func showListName()
}

protocol SpotifyTracklistWorkerDelegate: class {
    
    func spotifyTrackList(itens: SpotifyTracklist?)
}

class SpotifyTracklistInteractor: SpotifyTracklistBusinessLogic {
    
    var worker: SpotifyTracklistWorkerProtocol?
    
    var presenter: SpotifyTracklistPresentationLogic?
    
    var token: String = ""
    
    var playlistId: String = ""
    
    var listName: String = ""
    
    func trackListSpotify() {
        let request = Tracklist.FetchTrackList.Request(token: token, playlistId: playlistId)
        worker?.spotifyRequestList(request: request)
    }
    
    func showListName() {
        let response = Tracklist.PlayListName.Response(name: listName)
        presenter?.presenterListName(response: response)
    }
}

extension SpotifyTracklistInteractor: SpotifyTracklistWorkerDelegate {
    
    func spotifyTrackList(itens: SpotifyTracklist?) {
        let response = Tracklist.FetchTrackList.Response(tracklist: itens)
        presenter?.presentFetchedTracklist(response: response)
    }
    
}
