//
//  AuthSpotify.swift
//  GuessTheSong_Swift
//
//  Created by Nour Habib on 2021-06-09.
//

import Foundation




class AuthSpotify{
    static let shared = AuthSpotify()
    
    private var authorize: Bool!
    
    init(){}
    
    let clientID = ""
    let clientSecret = ""
    var accessToken = ""
    let baseURL = "https://accounts.spotify.com/api/token"
    
    public func connect()
    {
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
                print(" it is error")
                return
            }
            
            do
            {
                let result = try? JSONSerialization.jsonObject(with: data, options: [])
                if let JSON = result as? [String: Any]
                {
                    let status = JSON["access_token"] as! String
                    self?.accessToken = status
                    UserDefaults.standard.set(self?.accessToken,forKey:"token")
                    self?.authorize = true
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
