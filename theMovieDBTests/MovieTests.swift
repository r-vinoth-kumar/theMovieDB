//
//  MovieTests.swift
//  theMovieDBTests
//
//  Created by Vinoth Kumar Ramalingam on 06/08/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

import XCTest

@testable import theMovieDB

class MovieTests: XCTestCase {

    var movieList: [Movie]?

    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: type(of: self))
        let movieListFileURL = bundle.url(forResource: "movie-list", withExtension: "json")
        do {
            let movieListJsonData: Data = try Data(contentsOf: movieListFileURL!)
            movieList = try JSONDecoder().decode(QueryResult.self, from: movieListJsonData).results
        } catch {
        }
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMovieLoadPosterImage() {
        let movie = movieList![0]
        movie.loadPosterImage { (img) in
            XCTAssertNotNil(img)
        }
    }

    func testMovieLoadBackdropImage() {
        let movie = movieList![0]
        movie.loadPosterImage { (img) in
            XCTAssertNotNil(img)
        }
    }

    func testEqualMovie() {
        let movie = movieList![0]
        let isSameMovie = (movie == movieList![0])
        XCTAssertEqual(isSameMovie, true)
        XCTAssertEqual(movie.id, movieList![0].id)
    }

    func testNotEqualMovie() {
        let movie = movieList![0]
        let isNotSameMovie = (movie != movieList![1])
        XCTAssertEqual(isNotSameMovie, true)
    }

    func testMovieIsEditorsChoice() {
        var movie = movieList![0]
        movie.voteAvarage = 7.5
        movie.popularity = 300.0
        XCTAssertEqual(movie.isEditorsChoice, true)
        movie.popularity = 200.0
        XCTAssertEqual(movie.isEditorsChoice, false)
    }

    func testMovieIsTrending() {
        var movie = movieList![0]
        movie.popularity = 310.0
        XCTAssertEqual(movie.isTrending, true)
        movie.popularity = 200.0
        XCTAssertEqual(movie.isTrending, false)
    }

    func testMovieIsNew() {
        let movie = movieList![0]
        XCTAssertEqual(movie.isNewRelease, true)
    }

    func testMovieReleaseYear() {
        let movie = movieList![0]
        XCTAssertEqual(movie.releaseYear, 2018)
    }
}
