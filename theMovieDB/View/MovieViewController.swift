//
//  ViewController.swift
//  theMovieDB
//
//  Created by Vinoth Kumar Ramalingam on 30/07/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

import UIKit

class MovieViewController: BaseViewController {

    private var loadingPlaceholder = true
    private var searchController : UISearchController!
    private lazy var refreshControlView: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefreshMovies), for: .valueChanged)
        refreshControl.tintColor = UIColor.white
        return refreshControl
    }()

    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fillCollectionViewUsingPlaceholder {
            self.reloadMoviesVC()
        }
        self.collectionView.refreshControl = refreshControlView
        self.searchController = UISearchController(searchResultsController:  nil)
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.placeholder = "Find your favorite movies"
        self.searchController.searchBar.tintColor = UIColor.white
        self.searchController.hidesNavigationBarDuringPresentation = true
        self.searchController.dimsBackgroundDuringPresentation = false

        self.definesPresentationContext = true
        self.navigationItem.searchController = searchController
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func fillCollectionViewUsingPlaceholder(done:@escaping () -> Void) {
        collectionView.reloadData()
        DispatchQueue.main.async {
            done()
        }
    }

    @objc private func pullToRefreshMovies() {
        self.refreshControlView.beginRefreshing()
        self.reloadMoviesVC(true)
    }

    private func reloadMoviesVC(_ isPullToRefresh: Bool = false) {
        //make API call to get the movies list
    }
}

extension MovieViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(searchBar)
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        search(searchBar)
        searchBar.resignFirstResponder()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    private func search(_ searchBar: UISearchBar) {
        fillCollectionViewUsingPlaceholder {
            self.reloadMoviesVC()
        }
    }
}

extension MovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return loadingPlaceholder ? 4 : 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell!

        if loadingPlaceholder {
            // Placehold cell
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCollectionCellPlaceholder", for: indexPath)
        } else {
        }
        return cell
    }
}

extension MovieViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if loadingPlaceholder {
            collectionView.deselectItem(at: indexPath, animated: false)
        } else {
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
}

extension MovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var screenWidth: CGFloat = 0.0
        screenWidth = self.view.bounds.width < self.view.bounds.height ? self.view.bounds.width - 20 : self.view.bounds.width/2 - 16
        return CGSize(width: screenWidth, height: (screenWidth * 0.56) + 41)
    }
}

