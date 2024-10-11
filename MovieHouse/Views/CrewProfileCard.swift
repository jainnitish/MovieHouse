//
//  CrewProfileCard.swift
//  MovieHouse
//
//  Created by Nitish Jain on 05/10/24.
//

import SwiftUI

struct CrewProfileCard: View {
    
    @ObservedObject private var imageLoader = ImageLoader()
    let profileURL: URL
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 80, height: 80)
            
            if imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .aspectRatio(contentMode: .fit)
                    .mask(Circle())
            }
        }
        .onAppear {
            self.imageLoader.loadImage(with: self.profileURL)
        }
    }
}

#Preview {
    CrewProfileCard(profileURL: Movie.stubbedMovie.backdropURL)
}
