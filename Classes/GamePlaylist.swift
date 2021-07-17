//
//  GamePlaylist.swift
//  GuessTheSong_Swift
//
//  Created by Nour Habib on 2021-06-12.
//

import Foundation

class GamePlaylist
{
    static let shared = GamePlaylist()
    
    struct playlistIDs
    {
        static let rapIds = ["3JdI9IvgSxFM3bttMKPYCC","1tIioq32KjWlt5vvk5rhqX"]
        static let popIds = ["6odcotWv2xd7NP7RrGBS5b"] //90s
        static let rnbIds = ["0QhwxYDUougJiVDtyN4Lhm"]
        static let rockIds = ["5xrx34yrP6lj9NzvBx9PuT"]
    }
    
    let apiSpotify = APISpotify()

    private let playListLength: Int = 10
    private lazy var gameList: [Track] = []
    private lazy var trackOptionsList: [Track] = []
    var questionsArray: [Question] = []
    
    var albumList: [Track] = []
   
    
    public init(){}
    
    public func initializeGame(genre:String)
    {
    
        var ids = [String]()
        
        if(genre=="rap")
        {
            ids = playlistIDs.rapIds
        }
        else if(genre=="rnb")
        {
            ids = playlistIDs.rnbIds
        }
        else if(genre=="pop")
        {
            ids = playlistIDs.popIds
        }
        else if(genre=="rock")
        {
            ids = playlistIDs.rockIds
        }
    
        let dispatch = DispatchGroup()
        for id in ids
        {
            dispatch.enter()
            APISpotify.shared.getAlbumList(id: id)
            {
                result in defer{
                   // dispatch.leave()
                }
                switch result{
                case .success(let value):
                    self.albumList.append(contentsOf:value)
                
                case .failure(let error):
                    print(error)
                }
            }
            dispatch.leave()
            
        }
        
        dispatch.notify(queue: .main)
        {
            self.removeNull(arr: self.albumList)
        }
       
    }
    
    private func removeNull(arr: [Track]) -> Void
    {
        var newArr: [Track] = []
        for track in arr
        {
            if (track.preview_url != "<null>" || track.preview_url != "" || track.preview_url != "nil")
            {
                newArr.append(track)
            }
        }
        self.createGamePlaylist(tracksArr: newArr)
    }

    private func createGamePlaylist(tracksArr: [Track]) -> Void
    {
 
        var qArr: [Question] = []
    
        for _ in 0...playListLength-1
        {
            let mainTrack = tracksArr.randomElement()
            
            let optionTracks1 = OptionTracks(optA:mainTrack!,optB:tracksArr.randomElement()!,optC:tracksArr.randomElement()!,optD: tracksArr.randomElement()!)
            
            let optionTracks2 = OptionTracks(optA:tracksArr.randomElement()!,optB:mainTrack!,optC:tracksArr.randomElement()!,optD: tracksArr.randomElement()!)
            
            let optionTracks3 = OptionTracks(optA:tracksArr.randomElement()!,optB:tracksArr.randomElement()!,optC:mainTrack!,optD: tracksArr.randomElement()!)
            
            let optionTracks4 = OptionTracks(optA:tracksArr.randomElement()!,optB:tracksArr.randomElement()!,optC:tracksArr.randomElement()!,optD: mainTrack!)
            
            let OTarray = [optionTracks1,optionTracks2,optionTracks3,optionTracks4]


            let question = Question(mainTrack: mainTrack!, optionTracks: OTarray.randomElement())
            qArr.append(question)
        }
        
        self.questionsArray = qArr
    }
   
    public func newGame() -> Array<Question>
    {
        return self.questionsArray
    }
    
}
