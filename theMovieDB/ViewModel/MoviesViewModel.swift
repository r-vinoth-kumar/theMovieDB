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

    func loadMovies(success: @escaping () -> Void) {
    }

    func loadMoreMovies(success: @escaping () -> Void) {
    }

    func removeAllMovies() {
        movies.removeAll()
    }

    var countMovies: Int {
        return movies.count
    }

    func movieAtIndex(_ index: Int) -> Movie? {
        guard movies.indices.contains(index) == true else { return nil }
        return movies[index]
    }
}
