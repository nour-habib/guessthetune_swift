//
//  GamePlaylistTest.swift
//  GuessTheTuneGameTests
//
//  Created by Nour Habib on 2023-12-19.
//

import XCTest
@testable import GuessTheTuneGame

class GamePlaylistTest: XCTestCase
{
    private var questionsArr: [Question]!
    private var tracks: [Track]!

    override func setUpWithError() throws
    {
        super.setUp()
       
        GamePlaylist.shared.initializeGame(genre: "pop")
        questionsArr = GamePlaylist.shared.newGame()
        
        let album = Album(album_type: "", artists: [Artist](), external_urls: ["" : ""], id: "", name: "", uri: "")
        let track1 = Track(album: album, artists: [Artist](), disc_number: 0, duration_ms: 0, explicit: false, external_urls: ["":""], id: " ", name: "", preview_url: "nil")
        let track2 = Track(album: album, artists: [Artist](), disc_number: 0, duration_ms: 0, explicit: false, external_urls: ["":""], id: " ", name: "", preview_url: "nil")
        let track3 = Track(album: album, artists: [Artist](), disc_number: 0, duration_ms: 0, explicit: false, external_urls: ["":""], id: " ", name: "", preview_url: "http://google.com")
        let track4 = Track(album: album, artists: [Artist](), disc_number: 0, duration_ms: 0, explicit: false, external_urls: ["":""], id: "4", name: "", preview_url: "nil")
        
        let dummyArray = [track1, track2, track3, track4]
        tracks = GamePlaylist.shared.removeNull_public(arr: dummyArray)
        
    }

    override func tearDownWithError() throws
    {
        questionsArr = nil
        tracks = nil
        try super.tearDownWithError()
    }

    func testExample() throws
    {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func test_questionsArr()
    {
        XCTAssertNotNil(questionsArr)
    }

    func test_removeNull()
    {
        XCTAssertEqual(tracks.count, 1)
    }
}
