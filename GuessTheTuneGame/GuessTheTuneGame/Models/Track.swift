//
//  Track.swift
//  GuessTheTuneGame
//
//  Created by Nour Habib on 2023-12-01.
//

import Foundation

struct TrackRoot: Codable
{
    let items: [Track]?
}
 
struct Track: Codable
{
    var album: Album?
    var artists: [Artist] = []
    //let available_markets: [String]
    var disc_number = 0
    var duration_ms = 0
    var explicit = false
    var external_urls = ["":""]
    var id = ""
    var name = ""
    var preview_url : String?
}
