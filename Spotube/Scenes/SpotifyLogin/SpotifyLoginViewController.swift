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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Hello world")
    }

    
    @IBAction func connectSpot(_ sender: Any) {
        
        let requestedScopes: SPTScope = [.appRemoteControl, .playlistReadPrivate]
        AppDelegate().sessionManager.initiateSession(with: requestedScopes, options: .default)
        
        let request = SpotifyLogin.FetchUser.Request(token: "XXXYYYY")
        interactor?.fetchLoginUser(request: request)
    }
    
}

extension SpotifyLoginViewController: SpotifyLoginDisplayLogic {
    
    func displayFetchedUser(viewModel: SpotifyLogin.FetchUser.ViewModel?) {
        print("Name: \(String(describing: viewModel?.displayedUser.displayName))")
    }
}

