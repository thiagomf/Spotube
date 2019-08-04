//
//  SpotifyPlaylistAPI.swift
//  Spotube
//
//  Created by Thiago M Faria on 04/08/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit
import Alamofire

protocol SpotifyPlaylistAPIInputProtocol: class {
    
    var remoteRequestHandler: SpotifyPlaylistOutputProtocol? { get set }
    
    func callAPIPlaylist(request: Playlist.FetchPlayList.Request)
}

class SpotifyPlaylistAPI: NSObject, SpotifyPlaylistAPIInputProtocol {
    
    var remoteRequestHandler: SpotifyPlaylistOutputProtocol?
    
    func callAPIPlaylist(request: Playlist.FetchPlayList.Request) {
        
        self.fetch(request: request, completion: { playlist in
            
            self.remoteRequestHandler?.fetchPlayListSpotify(itens: playlist)
            
        })
    }
    
    func fetch(request: Playlist.FetchPlayList.Request,
               completion: @escaping (SpotifyPlaylist?) -> Void) {
        
        guard let url = URL(string: "https://api.spotify.com/v1/users/\(request.userId)/playlists?offset=5") else {
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
                            
                            let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)
                            print(jsonString ?? "")
                            
                            let playlist = try jsonDecoder.decode(SpotifyPlaylist.self, from: jsonData)
                            completion(playlist)
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
