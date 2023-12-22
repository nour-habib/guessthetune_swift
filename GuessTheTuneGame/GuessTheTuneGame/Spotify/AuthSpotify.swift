//
//  AuthSpotify.swift
//  GuessTheTuneGame
//
//  Created by Nour Habib on 2023-12-01.
//

import Foundation

class AuthSpotify
{
    static let shared = AuthSpotify()
    
    private var authorize: Bool!
    
    init(){}
    
    let clientID = "c5d59c7f1afa410db79986d63090b2b2"
    let clientSecret = "14ab9809742e49e49980617741d6a436"
    var accessToken = ""
    let baseURL = "https://accounts.spotify.com/api/token"
    
    public func connect()
    {
        print("connect")
        guard let url = URL(string: baseURL) else {return}
        
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name:"grant_type",value:"client_credentials")]
        
       var urlRequest = URLRequest(url:url)
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = urlComponents.query?.data(using:.utf8)
        urlRequest.httpMethod = "POST"
        
        let headerParameter = clientID+":"+clientSecret
        let hp = headerParameter.data(using: .utf8)
        guard let base64 = hp?.base64EncodedString() else
        {
            print("fail")
            return
            
        }
        urlRequest.setValue("Basic \(base64)", forHTTPHeaderField: "Authorization")
        
        let urlSession = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let data = data,
                  error == nil else
            {
                return
            }
            do
            {
                let result = try? JSONSerialization.jsonObject(with: data, options: [])
                if let JSON = result as? [String: Any]
                {
                    print("authorization data: ", data)
                    let status = JSON["access_token"] as! String
                    print("token: ", status);
                    self?.accessToken = status
                    UserDefaults.standard.set(self?.accessToken,forKey:"token")
                    self?.authorize = true
                   
                    
                    print("connection successful.")
                }
            }
        
        }
        urlSession.resume()
    }
    
    private func authorized() -> Bool
    {
        return self.authorize
    }
}

