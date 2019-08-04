//
//  SpotifyPlaylistRouter.swift
//  Spotube
//
//  Created by Thiago M Faria on 02/08/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

//MARK: Wireframe -
protocol SpotifyPlaylistWireframeProtocol: class {
    
    static func createPlaylistScreenModule() -> SpotifyPlaylistViewController
    
    // PRESENTER -> WIREFRAME
    func routerGoPLaylistMusic(item: Item)
}

class SpotifyPlaylistRouter: SpotifyPlaylistWireframeProtocol {
    
    static func createPlaylistScreenModule() -> SpotifyPlaylistViewController {
        return UIViewController() as! SpotifyPlaylistViewController
    }
    
    func routerGoPLaylistMusic(item: Item) {
        
    }
    

}
