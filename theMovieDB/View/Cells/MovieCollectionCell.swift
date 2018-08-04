//
//  MovieCollectionCell.swift
//  theMovieDB
//
//  Created by Vinoth Kumar Ramalingam on 05/08/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

import UIKit

class MovieCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var imgAdult: UIImageView!
    @IBOutlet weak var imgTrending: UIImageView!
    @IBOutlet weak var imgNew: UIImageView!
    @IBOutlet weak var imgEditorsChoice: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var vote: UILabel!
    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var titleBackgroundView: UIView!

    private var movieId = 0

    var movie: Movie! {
        didSet {
            loadCell()
        }
    }

    private func loadCell() {
        self.renderUI()
        if let movieTitle = movie.title {
            self.title.text = "\(movieTitle)"
        }

        if let voteAvarage = movie.voteAvarage {
            self.vote.text = "\(voteAvarage)"
            self.vote.backgroundColor = voteAvarage > 5 ? UIColor(named: "goodRating") : UIColor(named: "lowRating")
            self.vote.textColor = voteAvarage > 5 ? .black : .white
            self.vote.clipsToBounds = true
        }

        if let popularRating = movie.popularity?.description {
            self.popularity.text = "\((popularRating as NSString).integerValue)"
            self.popularity.clipsToBounds = true
        }
        self.imgAdult.isHidden = !(movie.adult == true)
        self.releaseDate.text = "\(movie.releaseYear)"
        self.releaseDate.clipsToBounds = true
        self.movieId = movie.id

        self.imgNew.isHidden = !movie.isNewRelease
        self.imgEditorsChoice.isHidden = !movie.isEditorsChoice
        self.imgTrending.isHidden = !movie.isTrending

        if self.reuseIdentifier == "movieCollectionCell" {
            movie.loadBackdropImage { (image) in
                if self.movie.id == self.movieId {
                    DispatchQueue.main.async {
                        self.imgBackground.image = image
                    }
                }
            }
        }
    }

    public func renderUI() {
        self.layer.cornerRadius = 20.0
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
    }
}
