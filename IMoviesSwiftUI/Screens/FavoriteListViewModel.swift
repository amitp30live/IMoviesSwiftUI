//
//  FavoriteListViewModel.swift
//  IMoviesSwiftUI
//
//  Created by AMIT on 10/08/24.
//

import Foundation
import SwiftUI

class FavoriteListViewModel: ObservableObject {
    @Published var favorites: [Movie] = []
   // @ObservedObject private var favoriteManager = FavoriteManager()
    
    func loadFavorites() {
        favorites = FavoriteManager.shared.favorites
        updateMoviesWithFavorites()
    }
    
    func isFavorite(movie: Movie) -> Bool {
        return FavoriteManager.shared.isFavorite(movie: movie)
    }
    
    func removeFavorite(movie: Movie) {
        FavoriteManager.shared.removeFavorite(movie: movie)
        loadFavorites()
    }
    
    func toggleFavorite(movie: Movie) {
        FavoriteManager.shared.toggleFavorite(movie: movie)
        updateMoviesWithFavorites()
    }
    
    private func updateMoviesWithFavorites() {
        for index in favorites.indices {
            favorites[index].isFavorite = FavoriteManager.shared.isFavorite(movie: favorites[index])
        }
    }
}

