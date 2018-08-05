//
//  QueryResult.swift
//  theMovieDB
//
//  Created by Vinoth Kumar Ramalingam on 04/08/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

struct QueryResult: Codable {

    var page: Int
    var totalResults: Int
    var totalPages: Int
    var results: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
