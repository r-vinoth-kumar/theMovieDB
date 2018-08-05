//
//  MovieParams.swift
//  theMovieDB
//
//  Created by Vinoth Kumar Ramalingam on 05/08/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

struct MovieParams {

    enum MovieType {
        case discover
        case search
    }

    var page: Int
    var query: String
    var type: MovieType
}
