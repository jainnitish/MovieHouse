//
//  MovieDetailImageView.swift
//  MovieHouse
//
//  Created by Nitish Jain on 05/10/24.
//

import SwiftUI

struct MovieDetailImageView: View {
    
    @ObservedObject private var imageLoader = ImageLoader()
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
            
            if imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
}

#Preview {
    MovieDetailImageView(imageURL: Movie.stubbedMovie.backdropURL)
}
