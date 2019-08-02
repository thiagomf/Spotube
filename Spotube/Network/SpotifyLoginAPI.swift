//
//  SpotifyAPI.swift
//  Spotube
//
//  Created by Thiago M Faria on 31/07/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit
import Alamofire

protocol SpotifyLoginAPIInputProtocol: class {
    
    var remoteRequestHandler: SpotifyLoginOutputProtocol? { get set }
    
    func callAPILogin(token: String)
    
    func callRequestLogin()
    
    func disconectSpotify()
    
    func spotifyApplication(app: UIApplication,
                    open url: URL,
                    options: [UIApplication.OpenURLOptionsKey : Any])
}

class SpotifyLoginAPI: NSObject, SpotifyLoginAPIInputProtocol {

    var remoteRequestHandler: SpotifyLoginOutputProtocol?
    
    let SpotifyClientID = "3e30621ef80a47d6a1d8869dff72ce79"
    let SpotifyRedirectURL = URL(string: "Spotube://returnAfterLogin")!
    
    lazy var configuration = SPTConfiguration(
        clientID: SpotifyClientID,
        redirectURL: SpotifyRedirectURL
    )
    
    lazy var sessionManager: SPTSessionManager = {
        if let tokenSwapURL = URL(string: "https://spotube.glitch.me/api/token"),
            let tokenRefreshURL = URL(string: "https://spotube.glitch.me/api/refresh_token") {
            self.configuration.tokenSwapURL = tokenSwapURL
            self.configuration.tokenRefreshURL = tokenRefreshURL
        }
        let manager = SPTSessionManager(configuration: self.configuration, delegate: self)
        return manager
    }()
    
    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
        appRemote.delegate = self
        return appRemote
    }()
    
    func callAPILogin(token: String) {
        self.fetch(token: token, completion: { user in
            
            self.remoteRequestHandler?.fetchUserSpotify(user: user)
           
        })
    }
    
    func fetch(token: String,
               completion: @escaping (User?) -> Void) {
        
        guard let url = URL(string: "https://api.spotify.com/v1/me") else {
            completion(nil)
            return
        }
        
        print("Token: \(token)")
        
        let header =  ["Accept":"application/json",
                       "Content-Type":"application/json",
                       "Authorization":"Bearer \(token)"]
        
        Alamofire.request(url,
                          method: .get,
                          headers: header).validate()
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    if let jsonData = response.data {
                        let jsonDecoder = JSONDecoder()
                        do {
                            
                            let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)
                            print(jsonString ?? "")
                            
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
    
    func callRequestLogin() {
        
        let requestedScopes: SPTScope = [.appRemoteControl, .playlistReadPrivate]
        self.sessionManager.initiateSession(with: requestedScopes, options: .default)
    }
    
    
    func disconectSpotify() {
        if self.appRemote.isConnected {
            self.appRemote.disconnect()
        }
    }
    
    func spotifyApplication(app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) {
        self.sessionManager.application(app, open: url, options: options)
    }

}

extension SpotifyLoginAPI: SPTSessionManagerDelegate {
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        self.appRemote.connectionParameters.accessToken = session.accessToken
        self.appRemote.connect()
        remoteRequestHandler?.tokenAcess(token: session.accessToken)
        print("success", session)
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print("fail", error)
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print("renewed", session)
    }
    
}

extension SpotifyLoginAPI: SPTAppRemoteDelegate {
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        print("connected")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("disconnected")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("failed")
    }
    
}

extension SpotifyLoginAPI: SPTAppRemotePlayerStateDelegate {
    
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        debugPrint("Track name: %@", playerState.track.name)
        print("player state changed")
    }
}
