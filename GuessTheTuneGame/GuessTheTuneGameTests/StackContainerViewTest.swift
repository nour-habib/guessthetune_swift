//
//  StackContainerViewTest.swift
//  GuessTheTuneGameTests
//
//  Created by Nour Habib on 2023-12-20.
//

import XCTest
@testable import GuessTheTuneGame

class StackContainerViewTest: XCTestCase
{
    private var stackContainerView: StackContainerView!
    private var datasource: SwipeCardViewDataSource!

    override func setUpWithError() throws
    {
        super.setUp()
        stackContainerView = StackContainerView(genre: "pop")
       
    }

    override func tearDownWithError() throws
    {
        super.tearDown()
        stackContainerView = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_stackContainerView()
    {
        XCTAssertNil(stackContainerView)
    }

}
