//
//  SpotifyLoginRouter.swift
//  Spotube
//
//  Created by Thiago M Faria on 31/07/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

//MARK: Wireframe -
protocol SpotifyLoginWireframeProtocol: class {
    
    static func createLoginScreenModule() -> SpotifyLoginViewController
    
    // PRESENTER -> WIREFRAME
    func routerGoUserPLaylist(user: SpotifyLogin.FetchUser.ViewModel.DisplayedUser?)
}

class SpotifyLoginRouter: SpotifyLoginWireframeProtocol {
    
    static func createLoginScreenModule() -> SpotifyLoginViewController {
        let navController = Storyboard.spotifyLoginStoryboard.instantiateViewController(withIdentifier: "SpotifyLogin")
        if let view = navController as? SpotifyLoginViewController {
            
            let interactor: SpotifyLoginBusinessLogic & SpotifyLoginWorkerDelegate = SpotifyLoginInteractor()
            let worker: SpotifyLoginWorkerProtocol & SpotifyLoginOutputProtocol = SpotifyLoginWorker()
            let presenter : SpotifyLoginPresentationLogic = SpotifyLoginPresenter()
            let remoteDataManager: SpotifyLoginAPIInputProtocol = SpotifyLoginAPI()
            let wireFrame: SpotifyLoginWireframeProtocol = SpotifyLoginRouter()
            
            view.interactor = interactor
            view.wireFrame = wireFrame
            interactor.presenter = presenter
            interactor.worker = worker
            worker.remoteDataManager = remoteDataManager
            worker.interactor = interactor
            presenter.viewController = view
            remoteDataManager.remoteRequestHandler = worker
            
            return view
        }
        
        return UIViewController() as! SpotifyLoginViewController
    }
    
    func routerGoUserPLaylist(user: SpotifyLogin.FetchUser.ViewModel.DisplayedUser?) {
        
        let window = UIApplication.shared.delegate?.window
        window??.rootViewController = SpotifyPlaylistRouter.createPlaylistScreenModule(user: user)
        window??.makeKeyAndVisible()
    }
    
}
