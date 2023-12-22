//
//  GamePlaylist.swift
//  GuessTheTuneGame
//
//  Created by Nour Habib on 2023-12-01.
//

import Foundation

class GamePlaylist
{
    static let shared = GamePlaylist()
    
    struct playlistIDs
    {
        //"1tIioq32KjWlt5vvk5rhqX" rap id
        static let rapIds = ["3JdI9IvgSxFM3bttMKPYCC"]
        static let popIds = ["7z9bNKljyF4BCVf6srNhN0"]
        static let rnbIds = ["3pYzFXVQdVO8R1jXRUon2u"]
        static let rockIds = ["4Xx4P00hWGpP0yGIVnLIYV"]
        //rnb: 3pYzFXVQdVO8R1jXRUon2u
        //rnb: 0QhwxYDUougJiVDtyN4Lhm
        //reggaeton: 7z9bNKljyF4BCVf6srNhN0
        //5xrx34yrP6lj9NzvBx9PuT
        //pop: 6odcotWv2xd7NP7RrGBS5b
        
    }
    
    private let playListLength: Int = 10
    private var questionsArray: [Question]?
    
    public func newGame() -> Array<Question>
    {
        if let questionsArray = questionsArray
        {
            return questionsArray
        }
        else
        {
            return Array<Question>()
        }
    }
    
    /* Gets tracks from Spotify using album ids */
    public func initializeGame(genre:String)
    {
        print("initializeGame()")
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
        dispatch.enter()
        
        var albumList = [Track]()
        
        for id in ids
        {
            dispatch.enter()
            APISpotify.shared.getAlbumList(id: id)
            {
                result in defer{
                    dispatch.leave()
                }
                switch result{
                case .success(let value):
                    albumList.append(contentsOf:value)
                case .failure(let error):
                    print(error)
                }
            }
            dispatch.leave()
        }
        
        dispatch.notify(queue: .main)
        {
            print("notified: ", albumList)
            self.createGamePlaylist(tracksArr: albumList)
        }
    }
    
    /* Removes tracks with null url */
    private func removeNull(arr: [Track]) -> [Track]
    {
        var newArr = [Track]()
        
        for track in arr
        {
            if (track.preview_url != "<null>" && track.preview_url != "" &&  track.preview_url != "nil" && track.preview_url != " nil")
            {
                newArr.append(track)
            }
        }
    
        return newArr
    }

    /* Creates game questions */
    private func createGamePlaylist(tracksArr: [Track]) -> Void
    {
        print("createGamePlaylist()")
        print("tracksArr: ", tracksArr)
        let nullRemovedArr = removeNull(arr: tracksArr)
        
        var questionsArr = [Question]()
    
        for _ in 0...playListLength-1
        {
            let mainTrack = tracksArr.randomElement() ?? Track()
            
            var optTrackArr = getRandomTracks(tracksArray: nullRemovedArr);
            let optionTracks1 = OptionTracks(optA:mainTrack,optB:optTrackArr[0],optC:optTrackArr[1],optD:optTrackArr[2])
            
            optTrackArr = getRandomTracks(tracksArray: nullRemovedArr);
            let optionTracks2 = OptionTracks(optA:optTrackArr[0],optB:mainTrack,optC:optTrackArr[1],optD: optTrackArr[2])
            
            optTrackArr = getRandomTracks(tracksArray: nullRemovedArr);
            let optionTracks3 = OptionTracks(optA:optTrackArr[0],optB:optTrackArr[1],optC:mainTrack,optD:optTrackArr[2])
            
            optTrackArr = getRandomTracks(tracksArray: nullRemovedArr);
            let optionTracks4 = OptionTracks(optA:optTrackArr[0],optB:optTrackArr[1],optC:optTrackArr[2],optD: mainTrack)
            
            let OTarray = [optionTracks1,optionTracks2,optionTracks3,optionTracks4]

            let question = Question(mainTrack: mainTrack, optionTracks: OTarray.randomElement())
            
            questionsArr.append(question)
        }
        
        self.questionsArray = questionsArr
    }
    
    private func getRandomTracks(tracksArray:[Track]) -> Array<Track>
    {
        var newArr = [Track]()
        
        for _ in 1...3
        {
            let track_opt = tracksArray.randomElement() ?? Track()
            newArr.append(track_opt)
        }
        return newArr
    }
    
}

#if DEBUG
extension GamePlaylist
{
    func removeNull_public(arr: [Track]) -> [Track]
    {
        removeNull(arr: arr)
    }
}
#endif
