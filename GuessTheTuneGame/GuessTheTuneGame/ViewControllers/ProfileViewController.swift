//
//  ProfileViewController.swift
//  GuessTheTuneGame
//
//  Created by Nour Habib on 2023-12-18.
//

import UIKit

class ProfileViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //getUserDetails
    }
    
    private func getUserDetails()
    {
        let dispatch = DispatchGroup()
        dispatch.enter()
        dispatch.enter()
        APISpotify.shared.userProfile()
        {
            result in defer{
                dispatch.leave()
            }
            switch result{
            case .success(let value):
                print("value_userDetails: ", value)
                //self.albumList.append(contentsOf:value)
                
            case .failure(let error):
                print("Error getting playlist\n",error)
               
            }
        }
        dispatch.leave()
        
        dispatch.notify(queue: .main)
        {
            print("notify_getUserDetails")
        }
    }
}
