//
//  MoviesViewModel.swift
//  theMovieDB
//
//  Created by Vinoth Kumar Ramalingam on 05/08/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

import Foundation

protocol AsyncResponse {
    func doneLoadMoreMovies()
    func error(_ errorMessage: String)
}

class MoviesViewModel {

    var delegate: AsyncResponse?
    private var movies: [Movie] = [Movie]()
    private var pages: Int = 0
    var params = MovieParams(page: 1, query: "", type: .discover)

    func loadMovies(success: @escaping () -> Void) {
        MovieAPI().moviesWithParams(params, success: { (responseMovies, responsePages) in
            self.movies.append(contentsOf: responseMovies)
            self.pages = responsePages
            success()
        }) { (error) in
            self.delegate?.error(error)
        }
    }

    func loadMoreMovies(success: @escaping () -> Void) {
        if self.params.page < pages {
            self.params.page += 1
            self.loadMovies { () in
                success()
            }
        }
    }

    func removeAllMovies() {
        movies.removeAll()
    }

    var countMovies: Int {
        return movies.count
    }

    func movieAtIndex(_ index: Int) -> Movie? {
        guard movies.indices.contains(index) == true else { return nil }
        if movies.count < index + 2 {
            loadMoreMovies {
                self.delegate?.doneLoadMoreMovies()
            }
        }
        return movies[index]
    }
}

