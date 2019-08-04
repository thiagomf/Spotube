//
//  SpotifyLoginPresenter.swift
//  Spotube
//
//  Created by Thiago M Faria on 31/07/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

protocol SpotifyLoginPresentationLogic: class {
    
    var viewController: SpotifyLoginDisplayLogic? { get set }
    
    func presentFetchedUser(response: SpotifyLogin.FetchUser.Response)
    
    func presentNilUser()
}

class SpotifyLoginPresenter: SpotifyLoginPresentationLogic {

    weak var viewController: SpotifyLoginDisplayLogic?
    
    func presentFetchedUser(response: SpotifyLogin.FetchUser.Response) {
        
        if let user = response.user, let token = response.token {
            let displayedUser = convertUser(user: user, token: token)
            let viewModel = SpotifyLogin.FetchUser.ViewModel(displayedUser: displayedUser)
            viewController?.displayFetchedUser(viewModel: viewModel)
        }
    }
    
    func presentNilUser() {
        viewController?.displayFetchedUser(viewModel: nil)
    }
    
    private func convertUser(user: SpotifyUser, token: String) -> SpotifyLogin.FetchUser.ViewModel.DisplayedUser
    {
        let userViewModel = SpotifyLogin.FetchUser.ViewModel.DisplayedUser(id: user.id,
                                                                           displayName: user.displayName,
                                                                           image: user.images[0].url,
                                                                           token: token)
        
        return userViewModel
    }
    
}
