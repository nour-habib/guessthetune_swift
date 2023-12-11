//
//  Album.swift
//  GuessTheTuneGame
//
//  Created by Nour Habib on 2023-12-01.
//

import Foundation

struct Root: Codable
{
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
