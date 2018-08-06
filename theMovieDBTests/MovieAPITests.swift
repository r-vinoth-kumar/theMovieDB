//
//  MovieAPITests.swift
//  theMovieDBTests
//
//  Created by Vinoth Kumar Ramalingam on 05/08/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

import XCTest

@testable import theMovieDB

class MovieAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetMovieDetailsSuccess() {
        let id = 550
        MovieAPI().movieDetailsWithId(id, success: { (movie) in
            XCTAssertEqual(id, movie.id)
        }) { (errorMessage) in }
    }

    func testGetMovieDetailsFailed() {
        let id = -1
        MovieAPI().movieDetailsWithId(id, success: { (movie) in }) { (errorMessage) in
            XCTAssertNotNil(errorMessage)
        }
    }


    func testGetMovieListSuccess() {
        MovieAPI().moviesWithParams(MovieParams(page: 1, query: "", type: .discover), success: { (movies, page) in
            XCTAssertEqual(movies.count, 20)
        }) { (errorMessage) in }
    }

    func testGetMovieListFailed() {
        MovieAPI().moviesWithParams(MovieParams(page: 0, query: "", type: .discover), success: { (movies, page) in }) { (errorMessage) in
            XCTAssertNotNil(errorMessage)
        }
    }

    func testGetMovieImageSuccess() {
        MovieAPI().downloadImage("/kOELgNnVt6EGCjtDXx85YUw6p8X.jpg", withSize: 500, success: { (img) in
            XCTAssertNotNil(img)
        }) { (errorMessage) in }
    }

    func testGetMovieImageFailed() {
        MovieAPI().downloadImage("", withSize: 500, success: { (img) in }) { (errorMessage) in
            XCTAssertNotNil(errorMessage)
        }
    }
}
