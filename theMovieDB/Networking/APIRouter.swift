//
//  APIRouter.swift
//  theMovieDB
//
//  Created by Vinoth Kumar Ramalingam on 05/08/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

import UIKit

enum APIRouter {

    case image(size: Int, path: String)
    case movie(id: Int)
    case searchMovie(query: String, page: Int)
    case discoverMovie(page: Int)

    private var baseURL: URL {
        switch self {
        case .movie:
            return URL(string: "\(Constants.Server.baseURL)?\(Constants.ParameterKey.apiKey)=\(Constants.Server.apiKey)")!
        case .image(let size, _):
            return URL(string: "\(Constants.Server.imageURL)\(size)")!
        case .searchMovie(let query, let page):
            return URL(string: "\(Constants.Server.baseURL)?\(Constants.ParameterKey.apiKey)=\(Constants.Server.apiKey)&\(Constants.ParameterKey.sort)=\(Constants.ParameterValue.sortOrder)&\(Constants.ParameterKey.includeAdult)=true&\(Constants.ParameterKey.query)=\(query)&\(Constants.ParameterKey.page)=\(page)")!
        case .discoverMovie(let page):
            return URL(string: "\(Constants.Server.baseURL)?\(Constants.ParameterKey.apiKey)=\(Constants.Server.apiKey)&\(Constants.ParameterKey.sort)=\(Constants.ParameterValue.sortOrder)&\(Constants.ParameterKey.includeAdult)=true&\(Constants.ParameterKey.page)=\(page)")!
        }
    }

    private var path: String {
        switch self {
        case .image(_, let path):
            return "\(path)"
        case .movie(let id):
            return "/movie/\(id)"
        case .searchMovie:
            return "/search/movie"
        case .discoverMovie:
            return "/discover/movie"
        }
    }


    func asURLRequest() throws -> URLRequest {
        let url = baseURL.absoluteURL
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = "GET"
        urlRequest.cachePolicy = .useProtocolCachePolicy
        urlRequest.timeoutInterval = 100
        return urlRequest
    }
}
