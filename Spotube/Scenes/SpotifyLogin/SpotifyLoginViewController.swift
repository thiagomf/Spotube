//
//  ViewController.swift
//  Spotube
//
//  Created by Thiago Machado Faria on 07/06/2019.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

protocol SpotifyLoginDisplayLogic: class {
    
    var interactor: SotifyLoginBusinessLogic? { get set }
    
    func displayFetchedUser(viewModel: SpotifyLogin.FetchUser.ViewModel?)
}

class SpotifyLoginViewController: UIViewController {

    var interactor: SotifyLoginBusinessLogic?
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Hello world")
        
        setup()
    }

    func setup() {
        
        let viewController = self
        let interactor = SpotifyLoginInteractor()
        let presenter = SpotifyLoginPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController

    }
    
    @IBAction func connectSpot(_ sender: Any) {
        
        let requestedScopes: SPTScope = [.appRemoteControl, .playlistReadPrivate]
        
        delegate.sessionManager.initiateSession(with: requestedScopes, options: .default)
    }
    
    
    @IBAction func teste(_ sender: Any) {
        
        let token = delegate.appRemote.connectionParameters.accessToken
        print(token ?? "")
        let request = SpotifyLogin.FetchUser.Request(token: token ?? "")
        interactor?.fetchLoginUser(request: request)
    }
    
}

extension SpotifyLoginViewController: SpotifyLoginDisplayLogic {
    
    func displayFetchedUser(viewModel: SpotifyLogin.FetchUser.ViewModel?) {
        print("Name: \(String(describing: viewModel?.displayedUser.displayName))")
    }
}

