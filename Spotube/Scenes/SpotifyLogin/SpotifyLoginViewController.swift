//
//  ViewController.swift
//  Spotube
//
//  Created by Thiago Machado Faria on 07/06/2019.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit
import JGProgressHUD

protocol SpotifyLoginDisplayLogic: class {
    
    var interactor: SpotifyLoginBusinessLogic? { get set }
    
    var wireFrame: SpotifyLoginWireframeProtocol? { get set }
    
    func displayFetchedUser(viewModel: SpotifyLogin.FetchUser.ViewModel?)
}

class SpotifyLoginViewController: UIViewController {

    var interactor: SpotifyLoginBusinessLogic?
    
    var wireFrame: SpotifyLoginWireframeProtocol?
    
    let hud = JGProgressHUD(style: .light)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hud.textLabel.text = "Carregando"
    }
    
    @IBAction func connectSpot(_ sender: Any) {
        hud.show(in: self.view)
        interactor?.loginSpotify()
    }
    
}

extension SpotifyLoginViewController: SpotifyLoginDisplayLogic {
    
    func displayFetchedUser(viewModel: SpotifyLogin.FetchUser.ViewModel?) {
        
        hud.dismiss()
        
        if let user = viewModel {
            print("Name: \(String(describing: user.displayedUser.displayName))")
            wireFrame?.routerGoUserPLaylist(user: user.displayedUser)
        }
        
    }
}

