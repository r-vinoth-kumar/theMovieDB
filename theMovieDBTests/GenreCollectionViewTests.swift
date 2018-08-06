//
//  GenreCollectionViewTests.swift
//  theMovieDBTests
//
//  Created by Vinoth Kumar Ramalingam on 05/08/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

import XCTest
import UIKit

@testable import theMovieDB

class GenreCollectionViewTests: XCTestCase {

    var movieDetails: Movie?
    var view: GenreCollectionView!

    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: type(of: self))
        let movieDetailFileURL = bundle.url(forResource: "movie-detail", withExtension: "json")
        do {
            let movieDetailJsonData = try Data(contentsOf: movieDetailFileURL!)
            movieDetails = try JSONDecoder().decode(Movie.self, from: movieDetailJsonData)
        } catch {
        }
        view = GenreCollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout.init())
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGenreCollectionView() {
        let genreList = movieDetails?.genres ?? []
        view.genreList = genreList
        XCTAssertEqual(genreList[0].name, view.genreList![0].name)

    }

    func testCollectionViewDidSelectItem() {
        view.delegate?.collectionView!(view, didSelectItemAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(view.indexPathsForSelectedItems?.count, 0)
    }
}
