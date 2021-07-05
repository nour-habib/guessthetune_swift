//
//  AuthSpotify.swift
//  GuessTheSong_Swift
//
//  Created by Nour Habib on 2021-06-09.
//

import Foundation
import Alamofire



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
        let parameters = ["client_id" : clientID,
                              "client_secret" : clientSecret,
                              "grant_type" : "client_credentials"]
        
        AF.request(baseURL, method: .post, parameters: parameters).responseJSON { (response) in
            switch response.result {
                            case .success(let value):
                                if let JSON = value as? [String: Any] {
                                    let status = JSON["access_token"] as! String
                                    self.accessToken = status
                                    UserDefaults.standard.set(status,forKey:"token")
                                    self.authorize = true
                            
                                    //print(self.accessToken)
                                    
                                }
                            case .failure(_): break
                                
                            }
                }
    }
    
    private func authorized() -> Bool
    {
        return self.authorize
        
    }
}
