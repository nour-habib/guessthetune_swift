//
//  Track.swift
//  GuessTheSong_Swift
//
//  Created by Nour Habib on 2021-06-10.
//

import Foundation

//struct TrackRoot: Codable{
//    let tracks: TrackSearch
//}

struct TrackRoot: Codable
{
    let items: [Track]
}
 
struct Track: Codable{
    let album: Album?
    let artists: [Artist]
    //let available_markets: [String]
    let disc_number: Int
    let duration_ms: Int
    let explicit: Bool
    let external_urls: [String:String]
    let id: String
    let name: String
    let preview_url: String?
    

}
