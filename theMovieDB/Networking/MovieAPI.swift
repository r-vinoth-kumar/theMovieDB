//
//  MovieAPI.swift
//  theMovieDB
//
//  Created by Vinoth Kumar Ramalingam on 05/08/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

import UIKit

class MovieAPI {

    private let session = URLSession(configuration: .default)
    private let decoder = JSONDecoder()

    func moviesWithParams(_ params: MovieParams, success: @escaping (_ movies: [Movie],_ pages: Int) -> Void, errorMessage: @escaping (String) -> Void) {
        var url: URLRequest?
        if params.type == .search {
            let q = params.query.lowercased().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            url = try? APIRouter.searchMovie(query: q, page: params.page).asURLRequest()

        } else if params.type == .discover {
            url = try? APIRouter.discoverMovie(page: params.page).asURLRequest()
        }
        guard let requestUrl = url else {
            errorMessage("Request URL error")
            return
        }
        session.dataTask(with: requestUrl, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            do {
                if let error = error {
                    errorMessage("Error getting response from server. \(error.localizedDescription)")
                    return
                }
                guard let data = data else { return }
                let queryResult = try self.decoder.decode(QueryResult.self, from: data)
                success(queryResult.results, queryResult.totalPages)
            } catch {
                errorMessage("Error getting response from server. \(error.localizedDescription)")
            }
        }).resume()
    }

    func downloadImage(_ imagePath: String, withSize size: Int, success: @escaping (UIImage) -> Void, errorMessage: @escaping (String) -> Void) -> Void {
        guard let url = try? APIRouter.image(size: size, path: imagePath).asURLRequest() else { return }
        session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            if let e = error {
                errorMessage(e.localizedDescription)
                return
            }
            guard let data = data else { return }
            if let image = UIImage(data: data) {
                success(image)
            } else {
                errorMessage("Loading Image Error - Result value nil")
            }
        }).resume()
    }

    func movieDetailsWithId(_ movieId: Int, success: @escaping (_ movie: Movie) -> Void, errorMessage: @escaping (String) -> Void) {
        guard let url = try? APIRouter.movie(id: movieId).asURLRequest() else { return }
        session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            do {
                if let error = error {
                    errorMessage("Error getting response from server. \(error.localizedDescription)")
                    return
                }
                guard let data = data else { return }
                let movie = try self.decoder.decode(Movie.self, from: data)
                success(movie)
            } catch {
                errorMessage("Error getting response from server. \(error.localizedDescription)")
            }
        }).resume()
    }
}
