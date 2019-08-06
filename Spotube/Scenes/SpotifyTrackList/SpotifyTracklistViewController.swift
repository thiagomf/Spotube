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
    
    func showListName(viewModel: Tracklist.PlayListName.ViewModel)
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
        confTb()
        fetchPTrackList()
    }
    
    func setupNavigation() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        interactor?.showListName()
    }
    
    func confTb() {
        
        let customCell = UINib(nibName: "SpotifyPlaylistViewCell", bundle: nil)
        trackTbv.register(customCell, forCellReuseIdentifier: "playlistCell")
        trackTbv.rowHeight = UITableView.automaticDimension
        trackTbv.estimatedRowHeight = 50
    }
    
    func confHUD() {
        hud.textLabel.text = "Carregando"
    }
    
    func fetchPTrackList(){
        hud.show(in: self.view)
        interactor?.trackListSpotify()
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        navigation?.popViewController(animated: true)
    }
    
}

extension SpotifyTracklistViewController: SpotifyTracklistDisplayLogic {
    
    func showListName(viewModel: Tracklist.PlayListName.ViewModel) {
        self.title = "\(viewModel.listName)"
    }
    

    func displayFetchedTracklist(viewModel: Tracklist.FetchTrackList.ViewModel) {
        itens = viewModel.displayedTracklist
        trackTbv.reloadData()
        hud.dismiss()
    }
    
}

extension SpotifyTracklistViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayedList = itens[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell") as! SpotifyPlaylistViewCell
        let url = URL.init(string: displayedList.albumImage)
        cell.albumImg?.kf.setImage(with: url)
        cell.albumLb?.text = displayedList.songName
        cell.ownerLb?.text = "criador: \(displayedList.artistName)"
        return cell
    }
    
}
