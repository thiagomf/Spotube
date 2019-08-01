//
//  SpotifyLoginPresenter.swift
//  Spotube
//
//  Created by Thiago M Faria on 31/07/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

protocol SpotifyLoginPresentationLogic {
    
    func presentFetchedUser(response: SpotifyLogin.FetchUser.Response)
}

class SpotifyLoginPresenter: NSObject, SpotifyLoginPresentationLogic {

    weak var viewController: SpotifyLoginDisplayLogic?
    
    func presentFetchedUser(response: SpotifyLogin.FetchUser.Response) {
        
        if let user = response.user {
            let displayedUser = convertUser(user: user)
            let viewModel = SpotifyLogin.FetchUser.ViewModel(displayedUser: displayedUser)
            viewController?.displayFetchedUser(viewModel: viewModel)
        } else {
            viewController?.displayFetchedUser(viewModel: nil)
        }
    }
    
    private func convertUser(user: User) -> SpotifyLogin.FetchUser.ViewModel.DisplayedUser
    {
        let userViewModel = SpotifyLogin.FetchUser.ViewModel.DisplayedUser(country: user.country,
                                                                           displayName: user.displayName,
                                                                           email: user.email,
                                                                           image: user.images[0].url)
        
        return userViewModel
    }
    
}
