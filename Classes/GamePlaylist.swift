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
    
    //let dispatchGroup = DispatchGroup()
    
    struct playlistIDs
    {
        static let rap = "1tIioq32KjWlt5vvk5rhqX"
        static let pop = "6odcotWv2xd7NP7RrGBS5b"
        static let rnb = "0QhwxYDUougJiVDtyN4Lhm"
        static let rock = "5xrx34yrP6lj9NzvBx9PuT"
    }
    
    let apiSpotify = APISpotify()

    private let playListLength: Int = 20
    private lazy var gameList: [Track] = []
    private lazy var trackOptionsList: [Track] = []
    var questionsArray: [Question] = []
    
    var albumList: [Track] = []
   
    
    public init(){}
    
    public func initializeGame(genre:String)
    {
        
        var id = String()
        
        if(genre=="rap")
        {
            id = playlistIDs.rap
        }
        else if(genre=="rnb")
        {
            id = playlistIDs.rnb
        }
        else if(genre=="pop")
        {
            id = playlistIDs.pop
        }
        else if(genre=="rock")
        {
            id = playlistIDs.rock
        }
    
        APISpotify.shared.getAlbumList(id: id){
            result in defer{
               // dispatchGroup.leave()
            }
            switch result{
            case .success(let value):
                self.albumList = value
                self.removeNull(arr: self.albumList)
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func removeNull(arr: [Track]) -> Void
    {
        var newArr: [Track] = []
        for track in arr
        {
            if (track.preview_url != "<null>" || track.preview_url != "")
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
        
        setQuestions(arr: qArr)
    }
    private func setQuestions(arr:Array<Question>)
    {
        self.questionsArray = arr

    }
    
    public func newGame() -> Array<Question>
    {
        return self.questionsArray
    }
    
}
