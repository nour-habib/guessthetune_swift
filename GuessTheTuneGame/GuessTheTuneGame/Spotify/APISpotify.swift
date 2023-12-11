//
//  APISpotify.swift
//  GuessTheTuneGame
//
//  Created by Nour Habib on 2023-12-01.
//

import Foundation

class APISpotify
{
    static let shared = APISpotify()
    let Auth = AuthSpotify()
    
    let apiURL = "https://api.spotify.com/v1"
    
    init()
    {
        Auth.connect()
    }
    
    public func search(query:String,completion: @escaping (Result<[Album],Error>) -> Void)
    {
        var searchResults = [Album]()
       
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string:apiURL+"/search?q="+query+"&type=album&market=us&limit=3&include_external=false") else {return}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        guard let token = UserDefaults.standard.string(forKey:"token") else {return}
        urlRequest.setValue("Bearer \(token)",forHTTPHeaderField: "Authorization")
        
        let urlSession = URLSession.shared.dataTask(with: urlRequest){data, response, error in
            guard let data = data, error == nil else
            {
                completion(.failure(APISpotifyError.searchError))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do
            {
                let albums = try jsonDecoder.decode(Root.self,from:data)
                searchResults.append(contentsOf: albums.albums.items)
                completion(.success(searchResults))
            }
            catch
            {
                completion(.failure(error))
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
        
        let currentGenre = UserDefaults.standard.string(forKey: "current_genre")
        let prevGenre = UserDefaults.standard.string(forKey: "previous_genre")
        
        print("currentGenre: ", currentGenre ?? "")
        print("previousGenre: ", prevGenre ?? "")
        
        //cache.removeAllCachedResponses()
        
        if(currentGenre == "")
        {
            if let data = cache.cachedResponse(for: urlRequest)?.data
            { print("data from cached.\n")
                do
                {
                    let tracks = try jsonDecoder.decode(TrackRoot.self,from:data)
                    print("tracks: ", tracks);
                    tracksArray.append(contentsOf: tracks.items ?? [])
                    //cache.removeCachedResponse(for: urlRequest) //test cache
                    
                    
                    completion(.success(tracksArray))
                }
                catch let e
                {
                    completion(.failure(e))
                }
            }
            
        }
        else
        {
            print("no cache.")
            //let dispatch = DispatchGroup();
            let urlSession = URLSession.shared.dataTask(with: urlRequest){ data, response, error in
                guard let data = data, error == nil else
                {
                    completion(.failure(APISpotifyError.getAlbumListError))
                    return
                }
                
                do
                {
                    //dispatch.enter();
                    let tracks = try jsonDecoder.decode(TrackRoot.self,from:data)
                    tracksArray.append(contentsOf: tracks.items ?? [])
                    print("tracks: ", tracks);
                    completion(.success(tracksArray))
                    //dispatch.leave()
                }
                catch
                {
                    completion(.failure(error))
                }
            }
            //dispatch.wait()
            urlSession.resume()
//            dispatch.notify(queue: .main)
//            {
//                print("notified")
//
//
//            }
        }
    }


    public func userProfile(completion: @escaping (Result<UserProfile,Error>) -> Void)
    {
        //var userDetailsArr = [Use]?
        
        guard let url = URL(string:apiURL+"/me") else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        guard let token = UserDefaults.standard.string(forKey:"token") else {return}
        urlRequest.setValue("Bearer \(token)",forHTTPHeaderField: "Authorization")
        
        let urlSession = URLSession.shared.dataTask(with: urlRequest){data, response, error in
            guard let data = data, error == nil else
            {
                completion(.failure(APISpotifyError.userProfileError))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do
            {
                print("userProfile: response: ", response)
                let userProfileInfo = try jsonDecoder.decode(UserProfile.self,from:data)
                print("userProfile info: ", userProfileInfo);
               // searchResults.append(contentsOf: albums.albums.items)
               // completion(.success(searchResults))
            }
            catch
            {
                completion(.failure(error))
            }
        }
        urlSession.resume()
    }
}

enum APISpotifyError: Error
{
    case userProfileError
    case getAlbumListError
    case searchError
}

