//
//  MovieBackgroundCarouselView.swift
//  MovieHouse
//
//  Created by Nitish Jain on 03/10/24.
//

import SwiftUI

struct MovieBackdropCarouselView: View {
    
    let title: String
    let movies: [Movie]
    
    @State var isPresented: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(self.movies) { movie in
                        MovieBackdropCard(movie: movie)
                            .frame(height: 200)
                            .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                            .padding(.trailing, movie.id == self.movies.last!.id ? 16 : 0)
                    }
                }
            }
        }
    }
}

#Preview {
    MovieBackdropCarouselView(title: "Latest", movies: Movie.stubbedMovies)
}
