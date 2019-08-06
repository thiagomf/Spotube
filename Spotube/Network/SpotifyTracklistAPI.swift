//
//  SpotifyTracklistAPI.swift
//  Spotube
//
//  Created by Thiago M Faria on 06/08/19.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit
import Alamofire

protocol SpotifyTracklistAPIInputProtocol: class {
    
    var remoteRequestHandler: SpotifyTracklistOutputProtocol? { get set }
    
    func callAPITracklist(request: Tracklist.FetchTrackList.Request)
}

class SpotifyTracklistAPI: NSObject, SpotifyTracklistAPIInputProtocol {
    
    var remoteRequestHandler: SpotifyTracklistOutputProtocol?
    
    func callAPITracklist(request: Tracklist.FetchTrackList.Request) {
        
        self.fetch(request: request,
                   completion: { tracklist in
                
                    self.remoteRequestHandler?.fetchTrackListSpotify(itens: tracklist)
        })
    }
    
    func fetch(request: Tracklist.FetchTrackList.Request,
               completion: @escaping (SpotifyTracklist?) -> Void) {
        
        guard let url = URL(string: "https://api.spotify.com/v1/playlists/\(request.playlistId)/tracks?fields=items(track(album(artists%2C%20images%2C%20name)%2C%20name%2C%20popularity))") else {
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
                            
                            let tracklist = try jsonDecoder.decode(SpotifyTracklist.self, from: jsonData)
                            completion(tracklist)
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
