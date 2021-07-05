//
//  Album.swift
//  GuessTheSong_Swift
//
//  Created by Nour Habib on 2021-06-10.
//

import Foundation

struct Root: Codable{
    let albums: SearchResponse
}

struct SearchResponse: Codable
{
    let items: [Album]
}

struct Album: Codable
{
    let album_type: String
    let artists: [Artist]
    let external_urls: [String: String]
    let id: String
    let name: String
    let uri: String
    
}

