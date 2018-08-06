//
//  MovieViewControllerTest.swift
//  theMovieDBTests
//
//  Created by Vinoth Kumar Ramalingam on 05/08/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

import XCTest
import UIKit

@testable import theMovieDB

class MovieViewControllerTests: XCTestCase {
    
    var viewController: MovieViewController!

    override func setUp() {
        super.setUp()
        //setup to create the ViewController
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        viewController = navigationController.topViewController as! MovieViewController

        //set it to the rootViewController
        UIApplication.shared.keyWindow!.rootViewController = viewController

        //prepare the views with IBOutlet and IBAction
        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(viewController.view)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCollectionViewCellsIsDisplayedWithMatchingData() {
        //1 Arrange
        var movieList: [Movie]!
        let bundle = Bundle(for: type(of: self))
        let movieListFileURL = bundle.url(forResource: "movie-list", withExtension: "json")
        do {
            let movieListJsonData: Data = try Data(contentsOf: movieListFileURL!)
            movieList = try JSONDecoder().decode(QueryResult.self, from: movieListJsonData).results
        } catch {
        }

        //2 Act
        viewController.collectionView.reloadData()
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.5))

        //3 Assert
        let cellsCount = viewController.collectionView.numberOfItems(inSection: 0)
        XCTAssertEqual(cellsCount, movieList.count, "Cells count should match array.count")
        let cells = viewController.collectionView.visibleCells as! [MovieCollectionCell]
        for I in 0...cells.count - 1 {
            let cell = cells[I]
            let movie: Movie = movieList[I]
            cell.movie = movie
            XCTAssertEqual(cell.vote.text , "\(movie.voteAvarage!)", "voteAvarage should be matching")
        }
    }

    func testCollectionViewSelectItem() {
        viewController.collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        XCTAssertEqual(viewController.collectionView.indexPathsForSelectedItems?.count, 1)
    }

    func testCollectionViewDidSelectItem() {
        viewController.collectionView(viewController.collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(viewController.collectionView.indexPathsForSelectedItems?.count, 0)
    }

    func testSearchBarCancelButtonClicked() {
        let searchbar = UISearchBar()
        viewController.searchBarCancelButtonClicked(searchbar)
        XCTAssertEqual(searchbar.text, "")
    }

    func testSearchBarWithoutTextSearchButtonClicked() {
        let searchbar = UISearchBar()
        viewController.searchBarSearchButtonClicked(searchbar)
        XCTAssertEqual(searchbar.isFirstResponder, false)
    }

    func testSearchBarWithTextSearchButtonClicked() {
        let searchbar = UISearchBar()
        searchbar.text = "test"
        viewController.searchBarSearchButtonClicked(searchbar)
        XCTAssertEqual(searchbar.text, "test")
    }

    func testSearchBarTextDidBeginEditing() {
        let searchbar = UISearchBar()
        viewController.searchBarTextDidBeginEditing(searchbar)
        XCTAssertEqual(searchbar.showsCancelButton, true)
    }

    func testAsynResponsesError() {
        let errorMessage = "Error"
        viewController.error(errorMessage)
        viewController.errorView?.showErrorWith(message: errorMessage, animated: false)
        XCTAssertEqual(viewController.errorView!.message.text, errorMessage)
    }

    func testAsynResponsesDoneLoadMoreMovies() {
        viewController.doneLoadMoreMovies()
        viewController.errorView?.hideError(animated: false)
        XCTAssertEqual(viewController.errorView!.isHidden, true)
    }

//    func testLoadMoreMovies() {
//        let cell = viewController.collectionView(viewController.collectionView, cellForItemAt: IndexPath(row: 21, section: 0)) as! MovieCollectionCell
//        XCTAssertNotNil(cell.movie)
//    }
}
