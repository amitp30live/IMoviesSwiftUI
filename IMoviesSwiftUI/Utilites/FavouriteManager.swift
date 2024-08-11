//
//  FavouriteManager.swift
//  IMoviesSwiftUI
//
//  Created by AMIT on 11/08/24.
//

import Foundation

class FavoriteManager {
    static let shared: FavoriteManager = FavoriteManager()
    private(set) var favorites: [Movie] = []

    init() {
        loadFavorites()
    }
    
    func toggleFavorite(movie: Movie) {
        if isFavorite(movie: movie) {
            removeFavorite(movie: movie)
        } else {
            addFavorite(movie: movie)
        }
    }

    func isFavorite(movie: Movie) -> Bool {
        return favorites.contains(where: { $0.id == movie.id })
    }

    private func addFavorite(movie: Movie) {
        favorites.append(movie)
        saveFavorites()
        self.loadFavorites()
    }

    func removeFavorite(movie: Movie) {
        favorites.removeAll(where: { $0.id == movie.id })
        saveFavorites()
        self.loadFavorites()
    }

    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: "favorites")
        }
    }

    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: "favorites"),
           let decodedFavorites = try? JSONDecoder().decode([Movie].self, from: data) {
            self.favorites = decodedFavorites
        }
    }
}
