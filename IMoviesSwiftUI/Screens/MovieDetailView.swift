//
//  MovieDetailView.swift
//  IMoviesSwiftUI
//
//  Created by AMIT on 10/08/24.
//

import SwiftUI

struct MovieDetailView: View {
    var movie: Movie
    
    var body: some View {
        ScrollView {
            // Poster Image at the top
            GeometryReader { geometry in
                RemoteImageView(url: movie.backdropURL, height: 240, width: geometry.size.width-28)
                                   .cornerRadius(10)
                                   .padding(.horizontal)
                           }
                           .frame(height: 240)
            
            HStack(alignment: .top) {
                RemoteImageView(url: movie.posterURL, height: 120, width: 120)
                    .cornerRadius(60)
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 3) // Add a white border around the image
                    )
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2) // Add a shadow with some opacity and offset
                
                VStack(alignment: .leading) { 
                    Text(movie.title)
                        .font(.title2)
                        .bold()
                        .lineLimit(2)
                        .padding(.top,30)

                    // Rating and Release Date
                            //  VStack(spacing: 10) {
                                  TitleValueView(title: "Rating:", value: String(format: "%.1f", movie.voteAverage))
                                  TitleValueView(title: "Release Date:", value: movie.releaseDate)
//                              }
//                              .padding(.horizontal)
//                    Text("Ratings: \(String(format: "%.1f", movie.voteAverage))")
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
//                    
//                    Text("Release Date: \(movie.fetchReleaseDate)")
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
                }
                .padding(.leading, 8)
            }
            .padding(.top, -30)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 15)

            VStack(alignment: .leading, spacing: 10) {
                Text("Overview")
                    .font(.headline)
                    .padding(.top)
                
                Text(movie.overview)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding([.leading, .trailing, .bottom])
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
