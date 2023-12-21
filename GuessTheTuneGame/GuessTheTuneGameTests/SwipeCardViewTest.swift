//
//  SwipeCardViewTest.swift
//  GuessTheTuneGameTests
//
//  Created by Nour Habib on 2023-12-20.
//

import XCTest
@testable import GuessTheTuneGame

class SwipeCardViewTest: XCTestCase
{
    private var swipeCardView: SwipeCardView!
    private var questionsArr: [Question]!

    override func setUpWithError() throws
    {
        super.setUp()
        
        swipeCardView = SwipeCardView(frame: .zero)
        let optionTracks = OptionTracks(optA: Track(), optB: Track(), optC: Track(), optD: Track())
        let q1 = Question(mainTrack: Track(), optionTracks: optionTracks)
        let q2 = Question(mainTrack: Track(), optionTracks: optionTracks)
        let q3 = Question(mainTrack: Track(), optionTracks: optionTracks)
        let q4 = Question(mainTrack: Track(), optionTracks: optionTracks)
        
        questionsArr = [q1,q2,q3,q4]
        swipeCardView.dataSource = questionsArr[2]
    }

    override func tearDownWithError() throws {
        super.tearDown()
        swipeCardView = nil
        questionsArr = nil
    }

    func testExample() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func test_dataSource()
    {
        XCTAssertNotNil(swipeCardView.dataSource)
    }
    
    func test_dataSourceOptionTracks()
    {
        XCTAssertNotNil(swipeCardView.dataSource?.optionTracks)
    }
    
    func test_dataSourceMainTracks()
    {
        XCTAssertNotNil(swipeCardView.dataSource?.mainTrack)
    }
}
