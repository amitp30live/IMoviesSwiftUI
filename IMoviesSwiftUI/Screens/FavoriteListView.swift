//
//  FavoriteListView.swift
//  IMoviesSwiftUI
//
//  Created by AMIT on 10/08/24.
//

import SwiftUI

struct FavoriteListView: View {
    @StateObject private var viewModel = FavoriteListViewModel()
    
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        NavigationView {
            if viewModel.favorites.isEmpty {
                         Text("No favorites yet")
                             .font(.headline)
                             .foregroundColor(.gray)
                             .padding()
                             .navigationTitle("Favorites")

            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.favorites) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                MovieGridItem(movie: movie) {
                                    viewModel.toggleFavorite(movie: movie)
                                }
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Favorites")

            }

        }
        .onAppear() {
            viewModel.loadFavorites()
        }
    }
}
