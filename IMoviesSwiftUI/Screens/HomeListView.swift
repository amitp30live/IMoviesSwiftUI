//
//  HomeView.swift
//  IMoviesSwiftUI
//
//  Created by AMIT on 10/08/24.
//

import SwiftUI

struct HomeListView: View {
    @StateObject private var viewModel = HomeListViewModel()
    
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.title)
                        .padding()
                        .multilineTextAlignment(.center)
                } else {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.movies, id: \.uuid) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                MovieGridItem(movie: movie) {
                                    viewModel.toggleFavorite(movie: movie)
                                }
                                .onAppear {
                                    viewModel.loadMoreContentIfNeeded(currentItem: movie)
                                }
                            }
                        }
                        
                        if viewModel.isLoading && !viewModel.isFromJson {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Popular Movies")
            .refreshable {
                viewModel.refresh()
            }
        }
        .onAppear() {
            viewModel.updateMoviesWithFavorites()
        }
    }
}

