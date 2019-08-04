//
//  SpotifyPlaylistPresenter.swift
//  Spotube
//
//  Created by Thiago M Faria on 02/08/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

protocol SpotifyPlaylistPresentationLogic: class {
    
    var viewController: SpotifyPlaylistDisplayLogic? { get set }
    
    func presentFetchedPlaylist(response: Playlist.FetchPlayList.Response)
    
    func presentNilPlaylist()
}

class SpotifyPlaylistPresenter: SpotifyPlaylistPresentationLogic {
    
    weak var viewController: SpotifyPlaylistDisplayLogic?
    
    func presentFetchedPlaylist(response: Playlist.FetchPlayList.Response) {
        
        if let playList = response.playlist?.items {
            
            let displayedItens = convertItens(itens: playList)
            let viewModel = Playlist.FetchPlayList.ViewModel(displayedPlaylist: displayedItens)
            viewController?.displayFetchedPlaylist(viewModel: viewModel)
        }
       
    }
    
    func presentNilPlaylist() {
        viewController?.displayFetchedPlaylist(viewModel: nil)
    }
    
    private func convertItens(itens: [Item]) -> Playlist.FetchPlayList.ViewModel.DisplayedPlayList
    {
        let itensViewModel = Playlist.FetchPlayList.ViewModel.DisplayedPlayList(itens: itens)
        
        return itensViewModel
    }
    
}
