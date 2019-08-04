//
//  SpotifyPlaylistViewController.swift
//  Spotube
//
//  Created by Thiago M Faria on 03/08/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit
import Kingfisher

protocol SpotifyPlaylistDisplayLogic: class {
    
    var interactor: SpotifyPlaylistBusinessLogic? { get set }
    
    var wireFrame: SpotifyPlaylistWireframeProtocol? { get set }
    
    var navigation: UINavigationController? { get }
    
    func displayFetchedPlaylist(viewModel: Playlist.FetchPlayList.ViewModel)
}

class SpotifyPlaylistViewController: UIViewController {

    var interactor: SpotifyPlaylistBusinessLogic?
    
    var wireFrame: SpotifyPlaylistWireframeProtocol?
    
    var navigation: UINavigationController? {
        return self.navigationController
    }
    
    @IBOutlet weak var playListTbv: UITableView!
    
    var navTitle: String = ""
    
    var itens: [Playlist.FetchPlayList.ViewModel.DisplayedPlayList] = []
    
    var token: String = ""
    
    var userId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPlayList()
       
    }
    
    func setupNavigation() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.title = "Olá \(navTitle)"
        self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
    }
    
    func fetchPlayList(){
        let request = Playlist.FetchPlayList.Request(token: token, userId: userId)
        interactor?.playListSpotify(request: request)
    }
}

extension SpotifyPlaylistViewController: SpotifyPlaylistDisplayLogic {
   
    func displayFetchedPlaylist(viewModel: Playlist.FetchPlayList.ViewModel) {
        itens = viewModel.displayedPlaylist
        playListTbv.reloadData()
    }
}

extension SpotifyPlaylistViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayedList = itens[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell") as? SpotifyPlaylistViewCell
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "playlistCell") as? SpotifyPlaylistViewCell
        }
        let url = URL.init(string: displayedList.image)
        cell?.albumImg.kf.setImage(with: url)
        cell?.albumLb.text = displayedList.name
        return cell!
    }
    
}
