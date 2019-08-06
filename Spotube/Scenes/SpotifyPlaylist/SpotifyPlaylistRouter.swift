//
//  SpotifyPlaylistRouter.swift
//  Spotube
//
//  Created by Thiago M Faria on 02/08/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

//MARK: Wireframe -
protocol SpotifyPlaylistWireframeProtocol: class {
    
    static func createPlaylistScreenModule(user: Login.FetchUser.ViewModel.DisplayedUser) -> UINavigationController
    
    // PRESENTER -> WIREFRAME
    func routerGoTracklistMusic(playList: String,
                               token: String,
                               listName: String,
                               nav: UINavigationController?)
}

class SpotifyPlaylistRouter: SpotifyPlaylistWireframeProtocol {
    
    static func createPlaylistScreenModule(user: Login.FetchUser.ViewModel.DisplayedUser) -> UINavigationController {
        
        let navController = Storyboard.spotifyPlaylistStoryboard.instantiateViewController(withIdentifier: "PlaylistNavigation") as! UINavigationController
        if let view = navController.children.first as? SpotifyPlaylistViewController {
            
            let presenter: SpotifyPlaylistPresentationLogic = SpotifyPlaylistPresenter()
            let interactor: SpotifyPlaylistBusinessLogic & SpotifyPlaylistWorkerDelegate = SpotifyPlaylistInteractor()
            let worker: SpotifyPlaylistWorkerProtocol & SpotifyPlaylistOutputProtocol = SpotifyPlaylistWorker()
            let remoteDataManager: SpotifyPlaylistAPIInputProtocol = SpotifyPlaylistAPI()
            let wireFrame: SpotifyPlaylistWireframeProtocol = SpotifyPlaylistRouter()
            
            view.interactor = interactor
            view.wireFrame = wireFrame
            interactor.name = user.displayName
            interactor.tokenId = user.token
            interactor.userId = user.id
            interactor.presenter = presenter
            interactor.worker = worker
            worker.remoteDataManager = remoteDataManager
            worker.interactor = interactor
            presenter.viewController = view
            remoteDataManager.remoteRequestHandler = worker
        }
        
        return navController
        
    }
    
    func routerGoTracklistMusic(playList: String,
                               token: String,
                               listName: String,
                               nav: UINavigationController?) {
    
        
        SpotifyTracklistRouter.createTracklistScreenModule(token: token, playList: playList, listName: listName, with: nav)
        
    }
    

}
