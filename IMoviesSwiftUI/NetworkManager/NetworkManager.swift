//
//  NetworkManager.swift
//  IMoviesSwiftUI
//
//  Created by AMIT on 10/08/24.
//

import Foundation
import Combine

enum HTTPMethod: String {
    case GET
    case POST
}

enum NetworkError: Error {
    case badURL
    case requestFailed
    case invalidResponse
    case unknown
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchMovies(from endpoint: Endpoint) -> AnyPublisher<[Movie], NetworkError> {
        URLSession.shared.dataTaskPublisher(for: endpoint.url!)
            .map(\.data)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .mapError { _ in NetworkError.requestFailed }
            .eraseToAnyPublisher()
    }
}
