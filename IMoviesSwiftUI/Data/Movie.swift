//
//  Movie.swift
//  IMoviesSwiftUI
//
//  Created by AMIT on 10/08/24.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
    let total_pages: Int
}

struct Movie: Identifiable, Codable {
    let id: Int
    let title: String
    let voteAverage: Double
    let overview: String
    let releaseDate: String
    let posterPath: String
    let backdropPath: String
    var isFavorite: Bool = false
    let uuid = UUID()

    enum CodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")!
    }
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")!
    }
    
    var fetchReleaseDate: String {
        let date = DateTimeUtility.getReleaseDateFromString(dateString: self.releaseDate )
        return DateTimeUtility.convertToLongDateFormat(from: date) ?? ""
    }
}
