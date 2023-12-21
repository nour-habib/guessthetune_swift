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

    override func setUpWithError() throws
    {
        super.setUp()
        
        swipeCardView = SwipeCardView(frame: .zero)
        let optionTracks = OptionTracks(optA: Track(), optB: Track(), optC: Track(), optD: Track())
        let q = Question(mainTrack: Track(), optionTracks: optionTracks)
        
        swipeCardView.dataSource = q
    }

    override func tearDownWithError() throws {
        super.tearDown()
        swipeCardView = nil
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
