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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        //continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        //XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
       
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
    }

    func testExample() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func test_questionsArr()
    {
        XCTAssertNotNil(questionsArr)
    }
    
    func test_questionsArrSize()
    {
        XCTAssertEqual(questionsArr.count, 10)
    }

    func test_removeNull()
    {
        XCTAssertEqual(tracks.count, 1)
    }
}
