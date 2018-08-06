//
//  APIRouterTests.swift
//  theMovieDBTests
//
//  Created by Vinoth Kumar Ramalingam on 05/08/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

import XCTest

@testable import theMovieDB

class APIRouterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAPIRouterImage() {
        do {
            let size: Int = 500
            let path: String = "/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg"
            let imageRequest = try APIRouter.image(size: size, path: path).asURLRequest().url?.absoluteString
            XCTAssertEqual("https://image.tmdb.org/t/p/w\(size)\(path)", imageRequest)
        }
        catch {
        }
    }

    func testAPIRouterMovie() {
        do {
            let id: Int = 550
            let movieRequest = try APIRouter.movie(id: id).asURLRequest().url?.absoluteString
            XCTAssertEqual("https://api.themoviedb.org/3/movie/\(id)?api_key=80e9afea56635f17c97e6ed2fe8629b8", movieRequest)
        }
        catch {
        }
    }

    func testAPIRouterSearchMovie() {
        do {
            let page: Int = 1
            let query: String = ""
            let searchMovieRequest = try APIRouter.searchMovie(query: query, page: page).asURLRequest().url?.absoluteString
            XCTAssertEqual("https://api.themoviedb.org/3/search/movie?api_key=80e9afea56635f17c97e6ed2fe8629b8&sort_by=popularity.desc&include_adult=false&query=\(query)&page=\(page)", searchMovieRequest)
        }
        catch {
        }
    }

    func testAPIRouterDiscoverMovie() {
        do {
            let page: Int = 1
            let discoverMovieRequest = try APIRouter.discoverMovie(page: page).asURLRequest().url?.absoluteString
            XCTAssertEqual("https://api.themoviedb.org/3/discover/movie?api_key=80e9afea56635f17c97e6ed2fe8629b8&sort_by=popularity.desc&include_adult=false&page=\(page)", discoverMovieRequest)
        }
        catch {
        }
    }
    
}
