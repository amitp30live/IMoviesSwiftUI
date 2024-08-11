//
//  APIEndPoints.swift
//  IMoviesSwiftUI
//
//  Created by AMIT on 10/08/24.
//

import Foundation

enum API {
    static let apiKey = "c9856d0cb57c3f14bf75bdc6c063b8f3"
    static let baseURL = "https://api.themoviedb.org/3"
}

//enum Endpoint {
//    case discoverMovies
//    
//    var url: URL {
//        switch self {
//        case .discoverMovies:
//            return URL(string: "\(API.baseURL)/discover/movie?api_key=\(API.apiKey)")!
//        }
//    }
//}
enum Endpoint {
    case discoverMovies(page: Int)
    
    var url: URL? {
        switch self {
        case .discoverMovies(let page):
            return URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=c9856d0cb57c3f14bf75bdc6c063b8f3&page=\(page)")
        }
    }
}
