//
//  Movie.swift
//  theMovieDB
//
//  Created by Vinoth Kumar Ramalingam on 04/08/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

import Foundation
import UIKit

struct Movie: Codable {

    let id: Int
    let title: String?
    var overview: String?
    var posterPath: String?
    var voteAvarage: Decimal?
    var voteCount: Int?
    var popularity: Decimal?
    let releaseDateString: String
    var backdropPath: String?
    var budget: Int?
    var revenue: Int?
    var runtime: Int?
    var adult: Bool?
    var genres: [Genre]?
    var tagline: String?
    var language: String?
    var homepage: String?

    var releaseDate: Date? {
        get {
            let dayTimeFormatter = DateFormatter()
            dayTimeFormatter.dateFormat = "yyyy-MM-dd"
            return dayTimeFormatter.date(from: self.releaseDateString)
        }
    }

    var releaseYear: Int {
        get {
            let calendar = Calendar.current
            if let releaseDate = self.releaseDate {
                return calendar.component(.year, from: releaseDate)
            } else {
                return 0
            }
        }
    }

    var isTrending: Bool {
        get {
            return isNewRelease && popularity ?? 0 > 300.0
        }
    }

    var isEditorsChoice: Bool {
        get {
            return voteAvarage ?? 0 > 7.0 && popularity ?? 0 > 250.0
        }
    }

    var isNewRelease: Bool {
        get {
            let calendar = Calendar.current
            if let releaseDate = self.releaseDate {
                return calendar.dateComponents([.month], from: releaseDate, to: Date()).month ?? 6 < 6
            } else {
                return false
            }
        }
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case voteAvarage = "vote_average"
        case voteCount = "vote_count"
        case popularity
        case releaseDateString = "release_date"
        case backdropPath = "backdrop_path"
        case budget
        case revenue
        case runtime
        case adult
        case genres
        case tagline
        case language = "original_language"
        case homepage
    }

    func loadPosterImage(success: @escaping (UIImage?) -> Void) -> Void {
        if let path = posterPath {
            MovieAPI().downloadImage(path, withSize: 500, success: { (image) in
                success(image)
            }, errorMessage: {_ in
                success(UIImage(named: "coverplaceholder"))
            })
        } else {
            success(UIImage(named: "coverplaceholder"))
        }
    }

    func loadBackdropImage(success: @escaping (UIImage?) -> Void) -> Void {
        if let path = backdropPath {
            MovieAPI().downloadImage(path, withSize: 500, success: { (image) in
                success(image)
            }, errorMessage: {_ in
                success(UIImage(named: "wideplaceholder"))
            })
        } else {
            success(UIImage(named: "wideplaceholder"))
        }
    }
}

extension Movie : Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }

    static func != (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id != rhs.id
    }
}

extension Movie : Hashable {
    var hashValue: Int {
        return id.hashValue
    }
}
