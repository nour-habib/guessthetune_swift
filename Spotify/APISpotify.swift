//
//  APISpotify.swift
//  GuessTheSong_Swift
//
//  Created by Nour Habib on 2021-06-09.
//

import Foundation

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
       
        let q = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        
        guard let url = URL(string:apiURL+"/search?q="+q+"&type=album&market=us&limit=3&include_external=false") else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        guard let token = UserDefaults.standard.string(forKey:"token") else {return}
        urlRequest.setValue("Bearer \(token)",forHTTPHeaderField: "Authorization")
        
        let urlSession = URLSession.shared.dataTask(with: urlRequest){data, response, error in
            guard let data = data, error == nil else
            {
                //completion(.failure(error))
                print("error")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do
            {
                let albums = try jsonDecoder.decode(Root.self,from:data)
                searchResults.append(contentsOf: albums.albums.items)
                completion(.success(searchResults))
            }
            catch let e
            {
                print("error \(e)")
            }
        }
        urlSession.resume()
    }
    
    public func getAlbumList(id: String,completion: @escaping (Result<[Track],Error>) -> Void)
    {
        var tracksArray = [Track]()
        
        let api_url = apiURL + "/albums/" + id + "/tracks?market=US&limit=50"
        
        guard let url = URL(string: api_url) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.cachePolicy = .returnCacheDataElseLoad
        
        
        guard let token = UserDefaults.standard.string(forKey:"token") else {return}
        urlRequest.setValue("Bearer \(token)",forHTTPHeaderField: "Authorization")
        
        let jsonDecoder = JSONDecoder()
        
        //Load from cache if available
        if let data = cache.cachedResponse(for: urlRequest)?.data
        {
            do
            {
                let tracks = try jsonDecoder.decode(TrackRoot.self,from:data)
                tracksArray.append(contentsOf: tracks.items)
                //cache.removeCachedResponse(for: urlRequest) //test cache
                
                completion(.success(tracksArray))
            }
            catch let e
            {
                print("urlcache error \(e)")
                
            }
        }
        else
        {
            let urlSession = URLSession.shared.dataTask(with: urlRequest){ data, response, error in
                guard let data = data, error == nil else
                {
                    //completion(.failure(error))
                    print("erro")
                    return
                }
                
                do
                {
                    let tracks = try jsonDecoder.decode(TrackRoot.self,from:data)
                    tracksArray.append(contentsOf: tracks.items)
                    completion(.success(tracksArray))
                }
                catch let e
                {
                    print("error \(e)")
                }
            }
            urlSession.resume()
            
        }
    }
    
}
