//
//  How2GoUITests.swift
//  How2GoUITests
//
//  Created by Mohammed Elsammak on 1/27/17.
//  Copyright © 2017 How2Go. All rights reserved.
//
// swiftlint:disable line_length
import XCTest

class How2GoUITests: XCTestCase {

    override func setUp() {
        super.setUp()

        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testUIData() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let app = XCUIApplication()

        let scrollViewsQuery = XCUIApplication().scrollViews
        let button = scrollViewsQuery.children(matching: .other).element.children(matching: .other).element.children(matching: .button).element(boundBy: 1)

        // Tap the right button twice "i.e navigate to 3rd route"
        button.tap()
        button.tap()

        // Swipe transit line till the end
        let collectionViewsQuery = scrollViewsQuery.otherElements.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 2).children(matching: .other).element.children(matching: .other).element.swipeLeft()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 3).children(matching: .other).element.children(matching: .other).element.swipeLeft()

        // Check for stop name
        XCTAssert(app.staticTexts["U Mohrenstr."].exists)

        // Check for number of stops in RouteDetailsViewController
        XCTAssert(app.staticTexts["11 stops"].exists)

    }

}
