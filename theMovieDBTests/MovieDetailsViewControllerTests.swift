//
//  MovieDetailsViewControllerTests.swift
//  theMovieDBTests
//
//  Created by Vinoth Kumar Ramalingam on 05/08/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

import XCTest
import UIKit

@testable import theMovieDB

class MovieDetailsViewControllerTests: XCTestCase {

    var viewController: MovieDetailsViewController!
    var movieDetails: Movie!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
        viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController

        let bundle = Bundle(for: type(of: self))
        let movieDetailFileURL = bundle.url(forResource: "movie-detail", withExtension: "json")
        do {
            let movieDetailJsonData = try Data(contentsOf: movieDetailFileURL!)
            movieDetails = try JSONDecoder().decode(Movie.self, from: movieDetailJsonData)
        } catch {
        }
        viewController.movieDetailVM = MovieDetailViewModel(movie: movieDetails)

        navigationController.setViewControllers([viewController], animated: false)

        //set it to the rootViewController
        UIApplication.shared.keyWindow!.rootViewController = viewController

        //prepare the views with IBOutlet and IBAction
        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(viewController.view)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        viewController.movieDetailVM.loadDetails {
        }
        //2 Act
        self.viewController.movieDetails?.reloadData()
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.5))

        //3 Assert
        let cells = viewController.movieDetails?.visibleCells
        XCTAssertEqual(cells!.count, 2)

        for I in 0...cells!.count - 1 {
            let cell = cells![I]
            if let imageCell = cell as? MovieImageCell {
                imageCell.movie = movieDetails
                XCTAssertEqual(imageCell.vote.text , "\(movieDetails.voteAvarage!)")
            }
            else if let overCell = cell as? MovieOverviewCell {
                overCell.movie = movieDetails
                overCell.genreView?.genreList = movieDetails.genres
                XCTAssertEqual(overCell.overview.text , "\(movieDetails.overview!)")
                XCTAssertEqual((overCell.genreView?.visibleCells[0] as! GenreCell).genre.text , "\(movieDetails.genres![0].name!)")
                overCell.openHomePage(overCell.homePage)
                XCTAssertEqual(overCell.homePageLink , movieDetails.homepage)
            }
        }
    }

    func testCollectionViewSelectItem() {
        viewController.movieDetails?.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        XCTAssertEqual(viewController.movieDetails?.indexPathsForSelectedItems?.count, 1)
    }

    func testCollectionViewDidSelectItem() {
        if let collectionVC = viewController.movieDetails {
            collectionVC.delegate?.collectionView!(collectionVC, didSelectItemAt: IndexPath(row: 0, section: 0))
        }
        XCTAssertEqual(viewController.movieDetails?.indexPathsForSelectedItems?.count, 0)
    }

    func testAsynResponsesDoneLoadMoreMovies() {
        viewController.doneLoadMoreMovies()
        XCTAssertEqual(viewController.errorView!.isHidden, true)
    }


    func testAsynResponsesError() {
        let errorMessage = "Error"
        viewController.error(errorMessage)
        viewController.errorView?.showErrorWith(message: errorMessage, animated: false)
        XCTAssertEqual(viewController.errorView!.message.text, errorMessage)
    }

}
