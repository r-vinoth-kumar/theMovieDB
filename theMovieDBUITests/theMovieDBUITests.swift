//
//  theMovieDBUITests.swift
//  theMovieDBUITests
//
//  Created by Vinoth Kumar Ramalingam on 30/07/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

import XCTest

class theMovieDBUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testMoveListView() {
        let app = XCUIApplication()
        app.launch()
        XCUIDevice.shared.orientation = .portrait
        XCUIDevice.shared.orientation = .landscapeLeft
        XCUIDevice.shared.orientation = .portrait
        XCUIDevice.shared.orientation = .landscapeRight
        XCUIDevice.shared.orientation = .portrait
    }

    func testMovieDetailsView() {
        let app = XCUIApplication()
        app.launch()
        app.collectionViews.cells.element(boundBy:0).tap()
        let theMovieDBBackButton = app.navigationBars["Details"].buttons["The Movie DB"]
        XCUIDevice.shared.orientation = .portrait
        app.collectionViews.cells.element(boundBy:0).swipeUp()
        XCUIDevice.shared.orientation = .landscapeLeft
        app.collectionViews.cells.element(boundBy:0).swipeUp()
        XCUIDevice.shared.orientation = .portrait
        app.collectionViews.cells.element(boundBy:0).swipeDown()
        XCUIDevice.shared.orientation = .landscapeRight
        app.collectionViews.cells.element(boundBy:0).swipeUp()
        XCUIDevice.shared.orientation = .portrait
        app.collectionViews.cells.element(boundBy:0).swipeDown()
        theMovieDBBackButton.tap()
    }

    func testOpenHomepageLink() {
        let app = XCUIApplication()
        app.launch()
        app.collectionViews.cells.element(boundBy:0).tap()

        let theMovieDBBackButton = app.navigationBars["Details"].buttons["The Movie DB"]
        let openLink = app.buttons["Open Link"]
        openLink.tap()
        app.webViews.firstMatch.swipeDown()
        app.webViews.firstMatch.swipeUp()
        let detailsBackButton = app.navigationBars.element(boundBy: 0).buttons.element(boundBy: 0)
        detailsBackButton.tap()
        theMovieDBBackButton.tap()
    }

    func testLoadMoreMovies() {
        let app = XCUIApplication()
        app.launch()
        for _ in 0...15 {
            app.collectionViews.cells.element(boundBy:1).swipeUp()
        }
        app.collectionViews.cells.element(boundBy:1).tap()
        let theMovieDBBackButton = app.navigationBars["Details"].buttons["The Movie DB"]
        app.collectionViews.cells.element(boundBy:0).swipeUp()
        theMovieDBBackButton.tap()
    }

    func testSearchBar() {
        let app = XCUIApplication()
        app.launch()
        app.collectionViews.cells.element(boundBy:0).swipeDown()

        let searchForMoviesSearchField = app.searchFields["Find your favorite movies"]
        searchForMoviesSearchField.tap()
        searchForMoviesSearchField.typeText("mission")
        app.typeText("\r")
        searchForMoviesSearchField.tap()

        let theMovieDBBackButton = app.navigationBars["Details"].buttons["The Movie DB"]
        app.collectionViews.cells.element(boundBy:0).tap()
        theMovieDBBackButton.tap()

        let cancelButton = app.buttons["Cancel"]
        cancelButton.tap()
    }

    func testPullToRefresh() {
        let app = XCUIApplication()
        app.launch()
        let firstCell = app.collectionViews.cells.element(boundBy:0)
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 6))
        start.press(forDuration: 0, thenDragTo: finish)
    }
    
}
