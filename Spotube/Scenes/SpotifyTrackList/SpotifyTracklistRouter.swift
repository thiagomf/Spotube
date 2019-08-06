//
//  SpotifyTracklistRouter.swift
//  Spotube
//
//  Created by Thiago M Faria on 05/08/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

//MARK: Wireframe -
protocol SpotifyTracklistWireframeProtocol: class {
    
    static func createTracklistScreenModule(token: String, playList: String, listName: String, with navigation: UINavigationController?)
    
    // PRESENTER -> WIREFRAME
//    func routerGotracklistMusic(item: Item)
}


class SpotifyTracklistRouter: SpotifyTracklistWireframeProtocol {

    static func createTracklistScreenModule(token: String,
                                            playList: String,
                                            listName: String,
                                            with navigation: UINavigationController?) {
        
        let navController = Storyboard.spotifyTracklistStoryboard.instantiateViewController(withIdentifier: "SpotifyTracklistViewController") as! UINavigationController
        if let view = navController.children.first as? SpotifyTracklistViewController {
            
            let presenter: SpotifyTracklistPresentationLogic = SpotifyTracklistPresenter()
            let interactor: SpotifyTracklistBusinessLogic & SpotifyTracklistWorkerDelegate = SpotifyTracklistInteractor()
            let worker: SpotifyTracklistWorkerProtocol & SpotifyTracklistOutputProtocol = SpotifyTracklistWorker()
            let remoteDataManager: SpotifyTracklistAPIInputProtocol = SpotifyTracklistAPI()
            let wireFrame: SpotifyTracklistWireframeProtocol = SpotifyTracklistRouter()
            
            view.interactor = interactor
            view.wireFrame = wireFrame
            interactor.playlistId = playList
            interactor.token = token
            interactor.listName = listName
            interactor.presenter = presenter
            interactor.worker = worker
            worker.remoteDataManager = remoteDataManager
            worker.interactor = interactor
            presenter.viewController = view
            remoteDataManager.remoteRequestHandler = worker
            
            navigation?.pushViewController(view, animated: true)
        }
        
        
    }
    
//    func routerGotracklistMusic(item: Item) {
//        
//    }
}
