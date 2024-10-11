//
//  MovieBackdropCard.swift
//  MovieHouse
//
//  Created by Nitish Jain on 03/10/24.
//

import SwiftUI

struct MovieBackdropCard: View {
    
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                
                if imageLoader.image != nil {
                    Image(uiImage: self.imageLoader.image!)
                        .resizable()
                }
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(8)
            .shadow(radius: 4)
            
            Text(movie.title)
                .font(.subheadline)
                .lineLimit(1)
        }
        .onAppear {
            self.imageLoader.loadImage(with: movie.backdropURL)
        }
    }
}

#Preview {
    MovieBackdropCard(movie: Movie.stubbedMovie)
}
