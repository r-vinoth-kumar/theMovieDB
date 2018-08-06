//
//  theMovieDBTests.swift
//  theMovieDBTests
//
//  Created by Vinoth Kumar Ramalingam on 30/07/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

import XCTest
@testable import theMovieDB

class theMovieDBTests: XCTestCase {
    
    var movieList: [Movie]?
    var movieDetails: Movie?

    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: type(of: self))
        let movieListFileURL = bundle.url(forResource: "movie-list", withExtension: "json")
        let movieDetailFileURL = bundle.url(forResource: "movie-detail", withExtension: "json")
        do {
            let movieListJsonData: Data = try Data(contentsOf: movieListFileURL!)
            movieList = try JSONDecoder().decode(QueryResult.self, from: movieListJsonData).results
            let movieDetailJsonData = try Data(contentsOf: movieDetailFileURL!)
            movieDetails = try JSONDecoder().decode(Movie.self, from: movieDetailJsonData)
        } catch {
        }
    }
    
    override func tearDown() {
        super.tearDown()
    }

    // MARK: IntExtension
    func testIntToRuntime() {
        let givenTime = 100
        let dayComponent = givenTime.toRuntime()
        XCTAssertEqual(dayComponent, "1h 40m")
    }

    func testIntToUSCurrency() {
        let givenRevenue = 100853753
        let dayComponent = givenRevenue.toUSCurrency()
        XCTAssertEqual(dayComponent, "$100,853,753.00")
    }
    
}
