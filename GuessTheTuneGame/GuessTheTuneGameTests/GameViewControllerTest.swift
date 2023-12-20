//
//  GameViewControllerTest.swift
//  GuessTheTuneGameTests
//
//  Created by Nour Habib on 2023-12-20.
//

import XCTest
@testable import GuessTheTuneGame

class GameViewControllerTest: XCTestCase
{
    private var gameViewController: GameViewController!
    private var swipeCardView: SwipeCardView!

    override func setUpWithError() throws
    {
        super.setUp()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        //continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
//        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        gameViewController = GameViewController("pop")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        gameViewController = nil
    }

    func testExample() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func test_gameViewController()
    {
        XCTAssertNotNil(gameViewController)
    }

}
