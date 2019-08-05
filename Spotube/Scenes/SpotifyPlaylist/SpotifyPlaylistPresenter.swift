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
}

class SpotifyPlaylistPresenter: SpotifyPlaylistPresentationLogic {
    
    weak var viewController: SpotifyPlaylistDisplayLogic?
    
    var itens: [Item] = []
    
    func presentFetchedPlaylist(response: Playlist.FetchPlayList.Response) {
        
        if let playList = response.playlist?.items {
            itens.append(contentsOf: playList)
            let displayedItens = convertItens(itens: itens)
            let viewModel = Playlist.FetchPlayList.ViewModel(displayedPlaylist: displayedItens)
            viewController?.displayFetchedPlaylist(viewModel: viewModel)
        }
       
    }
    
    private func convertItens(itens: [Item]) -> [Playlist.FetchPlayList.ViewModel.DisplayedPlayList]
    {
        return itens.map { Playlist.FetchPlayList.ViewModel.DisplayedPlayList(name: $0.name, image: $0.images[0].url, id: $0.id, owner: $0.owner.displayName) }
    }
    
}
