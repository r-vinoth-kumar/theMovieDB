//
//  MovieDetailsCell.swift
//  theMovieDB
//
//  Created by Vinoth Kumar Ramalingam on 05/08/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

import UIKit

protocol MovieDetailsCellBase {
    var movie: Movie? {get set}
}

class MovieImageCell : UICollectionViewCell, MovieDetailsCellBase {

    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var imgAdult: UIImageView!
    @IBOutlet weak var imgTrending: UIImageView!
    @IBOutlet weak var imgNew: UIImageView!
    @IBOutlet weak var imgEditorsChoice: UIImageView!
    @IBOutlet weak var vote: UILabel!
    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var releaseDate: UILabel!

    var movie: Movie? {
        didSet {
            loadCell()
        }
    }

    private func loadCell() {
        if let voteAvarage = movie?.voteAvarage {
            self.vote.text = "\(voteAvarage)"
            self.vote.backgroundColor = voteAvarage > 5 ? UIColor(named: "goodRating") : UIColor(named: "lowRating")
            self.vote.textColor = voteAvarage > 5 ? .black : .white
            self.vote.clipsToBounds = true
        }

        if let popularRating = movie?.popularity?.description {
            self.popularity.text = "\((popularRating as NSString).integerValue)"
            self.popularity.clipsToBounds = true
        }

        self.imgAdult.isHidden = !(movie?.adult == true)
        self.releaseDate.text = movie?.releaseYear.description
        self.releaseDate.clipsToBounds = true

        self.imgNew.isHidden = !(movie?.isNewRelease ?? false)
        self.imgEditorsChoice.isHidden = !(movie?.isEditorsChoice ?? false)
        self.imgTrending.isHidden = !(movie?.isTrending ?? false)


        movie?.loadPosterImage(success: { (image) in
            DispatchQueue.main.async {
                self.imgBackground.image = image
            }
        })
    }

}

protocol OpenLink {
    func openLink(_ link: String?)
}

class MovieOverviewCell : UICollectionViewCell, MovieDetailsCellBase {
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var revenue: UILabel!
    @IBOutlet weak var homePage: UIButton!
    @IBOutlet weak var overview: UITextView!

    @IBOutlet var genreView: GenreCollectionView?
    var homePageLink: String?
    var delegate: OpenLink?

    var movie: Movie? {
        didSet {
            if let runtime = movie?.runtime {
                self.runtime.text = runtime.toRuntime()
            }
            if let revenue = movie?.revenue {
                self.revenue.text = revenue.toUSCurrency()
            }
            if let lang = movie?.language {
                self.language.text = lang
            }
            if let overview = movie?.overview {
                self.overview.text = overview
            }
            if let genes = movie?.genres {
                self.genreView?.genreList = genes
            }
            if let link = movie?.homepage {
                self.homePageLink = link
                self.homePage.setTitle("Open Link", for: .normal)
            }
        }
    }

    @IBAction func openHomePage(_ sender: UIButton) {
        self.delegate?.openLink(homePageLink)
    }

}

class GenreCell : UICollectionViewCell {
    @IBOutlet weak var genre: UILabel!
}
