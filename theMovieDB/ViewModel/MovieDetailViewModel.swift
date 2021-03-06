//
//  MovieDetailViewModel.swift
//  theMovieDB
//
//  Created by Vinoth Kumar Ramalingam on 05/08/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

class MovieDetailViewModel {

    var movie : Movie
    var delegate: AsyncResponse?

    init(movie : Movie) {
        self.movie = movie
    }

    func loadDetails(success: @escaping () -> Void) {
        MovieAPI().movieDetailsWithId(movie.id, success: { (responseMovie) in
            self.movie.budget = responseMovie.budget
            self.movie.revenue = responseMovie.revenue
            self.movie.runtime = responseMovie.runtime
            self.movie.overview = responseMovie.overview
            self.movie.language = responseMovie.language
            self.movie.homepage = responseMovie.homepage
            self.movie.genres = responseMovie.genres
            success()
        }) { (error) in
            self.delegate?.error(error)
        }
    }

}
