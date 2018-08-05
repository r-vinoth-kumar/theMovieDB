//
//  MovieDetailsViewController.swift
//  theMovieDB
//
//  Created by Vinoth Kumar Ramalingam on 05/08/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

import UIKit

class MovieDetailsViewController: BaseViewController {

    @IBOutlet var movieDetails: UICollectionView?
    var addMovieSelectedColor: UIColor!
    var movieDetailVM : MovieDetailViewModel!
    var cellIdList : [String] = ["movieImageCell", "movieOverviewCell"]

    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailVM.delegate = self
        self.navigationController?.navigationBar.prefersLargeTitles = true
        movieDetailVM.loadDetails {
            DispatchQueue.main.async {
                self.hideError(animated: true)
                self.movieDetails?.reloadData()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "inAppLink") {
            let destinationVC = segue.destination as! InAppLinkViewController
            destinationVC.link = sender as! String
        }
    }
}

extension MovieDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellIdList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdList[indexPath.row], for: indexPath)
        if var detailsCell = cell as? MovieDetailsCellBase {
            detailsCell.movie = movieDetailVM.movie
        }
        if var detailsCell = cell as? MovieOverviewCell {
            detailsCell.delegate = self
        }
        return cell
    }
}

extension MovieDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
    }
}

extension MovieDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var screenWidth: CGFloat = 0.0
        screenWidth = self.view.bounds.width < self.view.bounds.height ? self.view.bounds.width : self.view.bounds.width/2
        return CGSize(width: screenWidth, height: (screenWidth * 1.3))
    }
}

extension MovieDetailsViewController: AsyncResponse {
    func doneLoadMoreMovies() {
    }

    func error(_ errorMessage: String) {
        DispatchQueue.main.async {
            self.showErrorWith(message: errorMessage, animated: true)
        }
    }
}

extension MovieDetailsViewController: OpenLink {
    func openLink(_ link: String?) {
        if let link = link {
            self.performSegue(withIdentifier: "inAppLink", sender: link)
        }
    }
}
