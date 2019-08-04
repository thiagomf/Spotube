//
//  SpotifyPlaylistViewController.swift
//  Spotube
//
//  Created by Thiago M Faria on 03/08/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

protocol SpotifyPlaylistDisplayLogic: class {
    
    var interactor: SpotifyPlaylistBusinessLogic? { get set }
    
    var wireFrame: SpotifyPlaylistWireframeProtocol? { get set }
    
    func displayFetchedPlaylist(viewModel: Playlist.FetchPlayList.ViewModel?)
}

class SpotifyPlaylistViewController: UIViewController {

    var interactor: SpotifyPlaylistBusinessLogic?
    
    var wireFrame: SpotifyPlaylistWireframeProtocol?
    
    @IBOutlet weak var playListTbv: UITableView!
    
    var navTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupNavigation() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.title = "Olá \(navTitle)"
    }
}

extension SpotifyPlaylistViewController: SpotifyPlaylistDisplayLogic {
   
    func displayFetchedPlaylist(viewModel: Playlist.FetchPlayList.ViewModel?) {
        
    }
    
}
