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
    
    func callAPIPlaylist(request: Playlist.FetchPlayList.Request, pagination: PaginationWorker)
}

class SpotifyPlaylistAPI: NSObject, SpotifyPlaylistAPIInputProtocol {
    
    var remoteRequestHandler: SpotifyPlaylistOutputProtocol?
    
    func callAPIPlaylist(request: Playlist.FetchPlayList.Request, pagination: PaginationWorker) {
        
        self.fetch(request: request,
                   pagination: pagination,
                    completion: { playlist in
            
                        self.remoteRequestHandler?.fetchPlayListSpotify(itens: playlist)
            
        })
    }
    
    func fetch(request: Playlist.FetchPlayList.Request,
               pagination: PaginationWorker,
               completion: @escaping (SpotifyPlaylist?) -> Void) {
        
        if let next = pagination.pagNext, let url = URL(string: next) {
            
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
        } else {
            completion(nil)
            return
        }
    }

}
