//
//  SpotifyTracklistPresenter.swift
//  Spotube
//
//  Created by Thiago M Faria on 05/08/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

protocol SpotifyTracklistPresentationLogic: class {
    
    var viewController: SpotifyTracklistDisplayLogic? { get set }
    
    func presentFetchedTracklist(response: Tracklist.FetchTrackList.Response)
}

class SpotifyTracklistPresenter: SpotifyTracklistPresentationLogic {
    
    var viewController: SpotifyTracklistDisplayLogic?
    
    func presentFetchedTracklist(response: Tracklist.FetchTrackList.Response) {
        
    }
    

}
