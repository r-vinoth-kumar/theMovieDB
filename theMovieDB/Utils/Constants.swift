//
//  Constants.swift
//  theMovieDB
//
//  Created by Vinoth Kumar Ramalingam on 30/07/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

struct Constants {
    struct Server {
        static let baseURL: String = "https://api.themoviedb.org/3"
        static let imageURL: String = "https://image.tmdb.org/t/p/w"
        static let apiKey: String = "80e9afea56635f17c97e6ed2fe8629b8"
    }

    struct ParameterKey {
        static let apiKey = "api_key"
        static let sort = "sort_by"
        static let query = "query"
        static let page = "page"
        static let id = "id"
        static let includeAdult = "include_adult"
    }

    struct ParameterValue {
        static let sortOrder = "popularity.desc"
    }
}
