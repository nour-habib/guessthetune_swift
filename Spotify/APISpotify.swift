//
//  APISpotify.swift
//  GuessTheSong_Swift
//
//  Created by Nour Habib on 2021-06-09.
//

import Foundation
import Alamofire

class APISpotify
{
    static let shared = APISpotify()
    let Auth = AuthSpotify()
    
    let apiURL = "https://api.spotify.com/v1"
    
    init(){
        Auth.connect()
    }
    
    public func search(query:String,completion: @escaping (Result<[Album],Error>) -> Void)
    {
        
        var searchResults = [Album]()
        let parameters = ["client_id" : Auth.clientID,
                          "access_token": UserDefaults.standard.string(forKey: "token"),
                          "client_secret" : Auth.clientSecret,
                                   "grant_type" : "client_credentials"]
     
        
        let q = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        
        AF.request("https://api.spotify.com/v1/search?q="+q+"&type=album&market=us&limit=10&include_external=false", method: .get, parameters: parameters).responseJSON { (response) in
            //print(response.result)
                switch response.result {
                    case .success:
                        if let jsonData = response.data
                        {
                            let jsonDecoder = JSONDecoder()
                            do{
                                let albums = try jsonDecoder.decode(Root.self,from:jsonData)
            
                                searchResults.append(contentsOf: albums.albums.items)
                                //print(searchResults.count)
                                completion(.success(searchResults))
                        
                            }
                            catch let e
                            {
                                print("error \(e)")
                            }
                            
                        }
                       
                    case .failure(_): break

                                }
        }
        
    }
    
    public func getAlbumList(id: String,completion: @escaping (Result<[Track],Error>) -> Void)
    {
        var tracksArray = [Track]()
        
        let parameters = ["client_id" : Auth.clientID,
                          "access_token": UserDefaults.standard.string(forKey: "token"),
                          "client_secret" : Auth.clientSecret,
                                   "grant_type" : "client_credentials"]
     
        let url = apiURL + "/albums/" + id + "/tracks?market=US&limit=50"

       
        AF.request(url, method: .get, parameters: parameters).responseJSON { (response) in
           // print(response.result)
                switch response.result {
                    case .success:
                        if let jsonData = response.data
                        {
                            let jsonDecoder = JSONDecoder()
                            do{
                                
                                let tracks = try jsonDecoder.decode(TrackRoot.self,from:jsonData)

                                tracksArray.append(contentsOf: tracks.items)
                                completion(.success(tracksArray))
                               
                        
                            }
                            catch let e
                            {
                                print("error \(e)")
                            }
                            
                        }
                       
                    case .failure(_): break

                    }
        }
    }
    
}
