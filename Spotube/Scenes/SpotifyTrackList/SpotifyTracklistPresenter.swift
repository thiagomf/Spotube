//
//  SpotifyTracklistPresenter.swift
//  Spotube
//
//  Created by Thiago M Faria on 05/08/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

protocol SpotifyTracklistPresentationLogic: class {
    
    var viewController: SpotifyTracklistDisplayLogic? { get set }
    
    func presentFetchedTracklist(response: Tracklist.FetchTrackList.Response)
    
    func presenterListName(response: Tracklist.PlayListName.Response)
}

class SpotifyTracklistPresenter: SpotifyTracklistPresentationLogic {

    weak var viewController: SpotifyTracklistDisplayLogic?
    
    func presentFetchedTracklist(response: Tracklist.FetchTrackList.Response) {
        
        if let trackList = response.tracklist?.items {

            let displayedItens = convertItens(itens: trackList)
            let viewModel = Tracklist.FetchTrackList.ViewModel(displayedTracklist: displayedItens)
            viewController?.displayFetchedTracklist(viewModel: viewModel)
        }
    }
    
    private func convertItens(itens: [TrackItem]) -> [Tracklist.FetchTrackList.ViewModel.DisplayedTrackList]
    {
        return itens.map { Tracklist.FetchTrackList.ViewModel.DisplayedTrackList(songName: $0.track.name,
                                                                                artistName: $0.track.album.artists[0].name,
                                                                                albumName: $0.track.album.name,
                                                                                albumImage: $0.track.album.images[0].url) }
    }
    
    func presenterListName(response: Tracklist.PlayListName.Response) {
        let hello = "\(response.name)"
        let viewModel = Tracklist.PlayListName.ViewModel(listName: hello)
        viewController?.showListName(viewModel: viewModel)
    }
}
