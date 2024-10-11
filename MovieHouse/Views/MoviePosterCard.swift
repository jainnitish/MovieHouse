//
//  MoviePosterCard.swift
//  MovieHouse
//
//  Created by Nitish Jain on 03/10/24.
//

import SwiftUI

struct MoviePosterCard: View {
    
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    private let posterCardHeight: CGFloat = 227
    private let posterCardWidth: CGFloat = 153
    
    var body: some View {
        ZStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: posterCardWidth, height: posterCardHeight)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .overlay(
                        Circle()
                            .fill(Color.yellow)
                            .frame(width: 48, height: 48)
                            .offset(x: -40, y: 115)
                    )
                    .overlay(
                        Text(movie.scoreText)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .offset(x: -40, y: 115)
                    )
                    
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: posterCardWidth, height: posterCardHeight)
                    .cornerRadius(8)
                
                Text(movie.title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.white.opacity(0.4))
            }
        }
        .frame(width: posterCardWidth, height: posterCardHeight+55)
        .shadow(radius: 4)
        .onAppear {
            imageLoader.loadImage(with: movie.posterURL)
        }
//        ZStack {
//            if let image = imageLoader.image {
//                Image(uiImage: image)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    
//            } else {
//                Rectangle()
//                    .fill(Color.gray.opacity(0.3))
//                
//                Text(movie.title)
//                    .font(.subheadline)
//                    .multilineTextAlignment(.center)
//            }
//        }
//        .frame(width: posterCardWidth, height: posterCardHeight)
//        .cornerRadius(8)
//        .shadow(radius: 4)
//        .onAppear {
//            imageLoader.loadImage(with: movie.posterURL)
//        }
    }
}

#Preview {
    MoviePosterCard(movie: Movie.stubbedMovie)
}
