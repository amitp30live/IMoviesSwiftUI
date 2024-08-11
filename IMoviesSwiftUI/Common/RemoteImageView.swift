//
//  RemoteImageView.swift
//  IMoviesSwiftUI
//
//  Created by AMIT on 10/08/24.
//

import SwiftUI

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

struct RemoteImageView: View {
    let url: URL
    let height: CGFloat
    let width: CGFloat

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: width, height: height)
                
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()  // Ensures the image fills the frame without cutting off content
                    .frame(width: width, height: height)
                    .clipped()  // Clips the image to fit the frame size
                    .cornerRadius(10)
                
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()  // Maintains aspect ratio within the frame
                    .frame(width: width, height: height)
                    .foregroundColor(.gray)
                    .cornerRadius(10)
                
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: width, height: height)
        .background(Color.gray.opacity(0.2))  // Optional: Add a background color to fill any blank space
        .cornerRadius(10)
    }
}
