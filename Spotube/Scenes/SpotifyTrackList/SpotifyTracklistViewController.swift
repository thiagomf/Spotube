//
//  SpotifyTracklistViewController.swift
//  Spotube
//
//  Created by Thiago M Faria on 05/08/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit
import Kingfisher
import JGProgressHUD

protocol SpotifyTracklistDisplayLogic: class {
    
    var interactor: SpotifyTracklistBusinessLogic? { get set }

    var wireFrame: SpotifyTracklistWireframeProtocol? { get set }
    
    var navigation: UINavigationController? { get }
    
    func displayFetchedTracklist(viewModel: Tracklist.FetchTrackList.ViewModel)
}

class SpotifyTracklistViewController: UIViewController {

    var navigation: UINavigationController? {
        return self.navigationController
    }
    
    var interactor: SpotifyTracklistBusinessLogic?
    
    var wireFrame: SpotifyTracklistWireframeProtocol?
    
    var itens: [Tracklist.FetchTrackList.ViewModel.DisplayedTrackList] = []
    
    let hud = JGProgressHUD(style: .light)
    
    @IBOutlet weak var trackTbv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()
        confHUD()
        fetchPTrackList()
    }
    
    func setupNavigation() {
        
    }
    
    func confHUD() {
        hud.textLabel.text = "Carregando"
    }
    
    func fetchPTrackList(){
        hud.show(in: self.view)
//        if let id = user?.id, let token = user?.token {
//            let request = Playlist.FetchPlayList.Request(token: token, userId: id)
//            interactor?.playListSpotify(request: request)
//        }
    }
    
}

extension SpotifyTracklistViewController: SpotifyTracklistDisplayLogic {

    func displayFetchedTracklist(viewModel: Tracklist.FetchTrackList.ViewModel) {
        
    }
    
}

//extension SpotifyTracklistViewController: UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////
////
////    }
//    
//}
