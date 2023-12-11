//
//  UserProfile.swift
//  GuessTheTuneGame
//
//  Created by Nour Habib on 2023-12-01.
//

import Foundation

struct UserProfile: Codable
{
    var country: String?
    var display_name: String?
    var email: String?
    var explicit_content: [String: Bool]?
    var external_urls: [String: String]?
    var id: String?
    var product: String?
//    let images = []
}
