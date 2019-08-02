//
//  ViewController.swift
//  Spotube
//
//  Created by Thiago Machado Faria on 07/06/2019.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

protocol SpotifyLoginDisplayLogic: class {
    
    var interactor: SpotifyLoginBusinessLogic? { get set }
    
    var wireFrame: SpotifyLoginWireframeProtocol? { get set }
    
    func displayFetchedUser(viewModel: SpotifyLogin.FetchUser.ViewModel?)
}

class SpotifyLoginViewController: UIViewController {

    var interactor: SpotifyLoginBusinessLogic?
    
    var wireFrame: SpotifyLoginWireframeProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Hello world")

    }
    
    @IBAction func connectSpot(_ sender: Any) {
        
        interactor?.loginSpotify()
    }
    
}

extension SpotifyLoginViewController: SpotifyLoginDisplayLogic {
    
    func displayFetchedUser(viewModel: SpotifyLogin.FetchUser.ViewModel?) {
        print("Name: \(String(describing: viewModel?.displayedUser.displayName))")
    }
}

