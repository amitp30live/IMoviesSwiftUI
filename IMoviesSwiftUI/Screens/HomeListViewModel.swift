//
//  HomeListViewModel.swift
//  IMoviesSwiftUI
//
//  Created by AMIT on 10/08/24.
//

import Foundation
import SwiftUI

class HomeListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading = false
    var isFromJson = false
    private var currentPage = 1
    private var totalPages = 1
   // @ObservedObject private var favoriteManager = FavoriteManager()
    
    init() {
        fetchMovies()
    }
    
    func fetchMovies(isRefreshing: Bool = false) {
        if isRefreshing {
            currentPage = 1
            movies.removeAll()
        }
        if isFromJson { return }
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        APIManager.shared.request(
            endpoint: .discoverMovies(page: currentPage),
            completion: { [weak self] (result: Result<MovieResponse, NetworkError>) in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.isLoading = false
                    
                    switch result {
                    case .success(let response):
                        self.movies.append(contentsOf: response.results)
                        self.currentPage += 1
                        self.totalPages = response.total_pages
                        self.updateMoviesWithFavorites()
                    case .failure:
                        if self.movies.isEmpty {
                            self.isFromJson = true
                            self.loadMoviesFromJSON()
                        } else {
                            self.errorMessage = "Failed to load more movies."
                        }
                    }
                }
            }
        )
    }
    
    func loadMoreContentIfNeeded(currentItem movie: Movie?) {
        guard let movie = movie else {
            fetchMovies()
            return
        }
        
        let thresholdIndex = movies.index(movies.endIndex, offsetBy: -5)
        if movies.firstIndex(where: { $0.id == movie.id }) == thresholdIndex && currentPage <= totalPages {
            fetchMovies()
        }
    }
    
    private func loadMoviesFromJSON() {
        guard let url = Bundle.main.url(forResource: "movies", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            errorMessage = "Failed to load local data."
            return
        }
        
        do {
            let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
            self.movies = movieResponse.results
        } catch {
            errorMessage = "Failed to parse local data."
        }
    }
    
    func refresh() {
        fetchMovies(isRefreshing: true)
    }
    
    func toggleFavorite(movie: Movie) {
        FavoriteManager.shared.toggleFavorite(movie: movie)
        updateMoviesWithFavorites()
    }
    
    func updateMoviesWithFavorites() {
        for index in movies.indices {
            movies[index].isFavorite = FavoriteManager.shared.isFavorite(movie: movies[index])
        }
    }
}
