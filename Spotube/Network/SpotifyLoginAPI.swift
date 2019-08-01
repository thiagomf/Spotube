//
//  SpotifyAPI.swift
//  Spotube
//
//  Created by Thiago M Faria on 31/07/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit
import Alamofire

protocol SpotifyLoginAPIInputProtocol {
    
    var remoteRequestHandler: SpotifyLoginOutputProtocol? { get set }
    
    func callAPILogin(request: SpotifyLogin.FetchUser.Request)
}

protocol SpotifyLoginOutputProtocol {
    
    func fetchUserSpotify(user: User?)
}

class SpotifyLoginAPI: NSObject, SpotifyLoginAPIInputProtocol {
    
    var remoteRequestHandler: SpotifyLoginOutputProtocol?
    
    func callAPILogin(request: SpotifyLogin.FetchUser.Request) {
        self.fetch(request: request, completion: { user in
            
            self.remoteRequestHandler?.fetchUserSpotify(user: user)
           
        })
    }
    
    
    func fetch(request: SpotifyLogin.FetchUser.Request,
               completion: @escaping (User?) -> Void) {
        
        guard let url = URL(string: "https://api.spotify.com/v1/me") else {
            completion(nil)
            return
        }
        
        let header =  ["Accept":"application/json",
                       "Content-Type":"application/json",
                       "Authorization":"Bearer \(request.token)"]
        
        Alamofire.request(url,
                          method: .get,
                          headers: header).validate()
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    if let jsonData = response.data {
                        let jsonDecoder = JSONDecoder()
                        do {
                            let user = try jsonDecoder.decode(User.self, from: jsonData)
                            completion(user)
                        } catch let error{
                            print("Erro: \(error.localizedDescription)")
                            completion(nil)
                            return
                        }
                    }
                case .failure(let error):
                    print("Erro: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
        }
    }

}
