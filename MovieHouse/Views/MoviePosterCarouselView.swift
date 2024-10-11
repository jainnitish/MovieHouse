//
//  MoviePosterCarouselView.swift
//  MovieHouse
//
//  Created by Nitish Jain on 04/10/24.
//

import SwiftUI

struct MoviePosterCarouselView: View {
    
    @EnvironmentObject var router: Router
    
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal, 16)
                .padding(.bottom, 4)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(movies) { movie in
                        MoviePosterCard(movie: movie)
                            .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                            .padding(.trailing, movie.id == self.movies.last!.id ? 16 : 0)
                            .onTapGesture {
                                router.navigate(to: .movieDetail(MovieId: movie.id))
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    MoviePosterCarouselView(title: "Now Playing", movies: Movie.stubbedMovies)
}
