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
    private var datasource: SwipeCardViewDataSource!
    private var delegate: SwipeCardDelegate!
    private var questionsArr: [Question]!

    override func setUpWithError() throws
    {
        super.setUp()

//        // In UI tests it is usually best to stop immediately when a failure occurs.
//        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        //XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
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
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        swipeCardView = nil
        datasource = nil
        delegate = nil
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
    
    func test_numberOfCards()
    {
        XCTAssertEqual(delegate.n, <#T##expression2: Equatable##Equatable#>)
    }
    
   
    

}
