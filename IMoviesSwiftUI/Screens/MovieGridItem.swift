//
//  MovieGridItem.swift
//  IMoviesSwiftUI
//
//  Created by AMIT on 10/08/24.
//

import SwiftUI

struct MovieGridItem: View {
    var movie: Movie
    var blockFavCalled: (() -> Void)?
    var body: some View {
        VStack {
            RemoteImageView(url: movie.posterURL, height: 190, width: (UIScreen.screenWidth-40)/2)
            VStack(alignment: .leading, spacing: 5) {
                
                Text(movie.title)
                    .font(.subheadline)
                    .lineLimit(2)
                    .padding(.bottom, 3)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    TitleValueView(title: "Rating:", value: String(format: "%.1f", movie.voteAverage))
                    
                    Spacer()
                    Button(action: {
                        blockFavCalled?()
                    }) {
                        Image(systemName: movie.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(movie.isFavorite ? .red : .gray)
                    }
                }
                .foregroundStyle(.black)
            }
            .padding(.horizontal, 10)
            .padding(.top, 6)
            .padding(.bottom, 10)
        }
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
