//
//  MovieDetailView.swift
//  MovieHouse
//
//  Created by Nitish Jain on 05/10/24.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movieId: Int
    @ObservedObject private var movieDetailViewModel = MovieDetailViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                LoadingIndicatorView(isLoading: self.movieDetailViewModel.isLoading, error: self.movieDetailViewModel.error) {
                    self.movieDetailViewModel.fetchMovie(id: movieId)
                }
                if let movie = movieDetailViewModel.movie {
                    VStack {
                        HStack {
                            Text(movie.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .padding()
                            Spacer()
                        }
                        
                        MovieDetailImageView(imageURL: movie.backdropURL)
                        
                        HStack(alignment: .top, spacing: 8) {
                            Text(movie.genreText)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .foregroundColor(.black)
                                .overlay(RoundedRectangle(cornerRadius: 12).fill(Color.gray.opacity(0.3)))
                            
                            Text(movie.yearText)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .foregroundColor(.black)
                                .overlay(RoundedRectangle(cornerRadius: 12).fill(Color.gray.opacity(0.3)))
                            
                            Text(movie.durationText)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .foregroundColor(.black)
                                .overlay(RoundedRectangle(cornerRadius: 12).fill(Color.gray.opacity(0.3)))
                            
                            Spacer()
                        }
                        .padding()
                        
                        Text(movie.overview)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 8)
                        
                        HStack(alignment: .center) {
                            if !movie.ratingText.isEmpty {
                                Text(movie.ratingText)
                                    .foregroundColor(.yellow)
                                    .font(.title2)
                            }
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.red)
                                .frame(width: 48, height: 36)
                                .overlay(
                                    Text(movie.scoreText)
                                        .font(.title3)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .foregroundColor(.white)
                                    
                                )
                            Spacer()
                        }
                        .padding()
                        
                        Divider()
                            .padding(.horizontal, 12)
                        
                        if let credits = movie.credits {
                            Text("Credits")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.top, 12)
                            
                            Group {
                                HStack {
                                    Text("Artists")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .padding()
                                    Spacer()
                                }
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(alignment: .top) {
                                        let artists = credits.cast.sorted { $0.order < $1.order }
                                        ForEach(artists) { artist in
                                            if let profilePathURL = artist.profilePathURL {
                                                VStack(alignment: .center, spacing: 8) {
                                                    CrewProfileCard(profileURL: profilePathURL)
                                                    Text(artist.name)
                                                        .font(.caption)
                                                        .multilineTextAlignment(.center)
                                                        .lineLimit(2, reservesSpace: true)
                                                        
                                                }
                                                .frame(maxWidth: 85)
                                                .padding(.leading, artist.id == artists.first?.id ? 12 : 0)
                                                .padding(.trailing, artist.id == artists.last?.id ? 12 : 0)
                                                .padding(.horizontal, 10)
                                            }
                                        }
                                    }
                                }
                            }
                            
                            
                            
                            Group {
                                HStack {
                                    Text("Crew Members")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .padding()
                                    Spacer()
                                }
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(alignment: .top) {
                                        let crew = credits.crew.filter { $0.job.lowercased() == "producer" || $0.job.lowercased() == "director" || $0.job.lowercased() == "screenplay" || $0.job.lowercased() == "editor" }
                                        ForEach(crew) { crewMember in
                                            if let profilePathURL = crewMember.profilePathURL {
                                                VStack(alignment: .center, spacing: 8) {
                                                    CrewProfileCard(profileURL: profilePathURL)
                                                    Text(crewMember.name)
                                                        .font(.caption)
                                                        .multilineTextAlignment(.center)
                                                        .lineLimit(2, reservesSpace: true)
                                                    Rectangle()
                                                        .fill(Color.gray.opacity(0.5))
                                                        .frame(width: 15, height: 1)
                                                    Text(crewMember.job)
                                                        .font(.caption2)
                                                        .fontWeight(.bold)
                                                    
                                                }
                                                .frame(maxWidth: 85)
                                                .padding(.leading, crewMember.id == crew.first?.id ? 12 : 0)
                                                .padding(.trailing, crewMember.id == crew.last?.id ? 12 : 0)
                                                .padding(.horizontal, 10)
                                            }
                                        }
                                    }
                                }
                            }
                            
                            Divider()
                                .padding(.horizontal, 12)
                            
                            if let videos = movie.videos,
                               !videos.results.isEmpty,
                               !videos.results.filter({ $0.isYoutubeTrailerVideo }).isEmpty {
                                
                                let youtubeTrailerVideos = videos.results.filter({ $0.isYoutubeTrailerVideo })
                                
                                HStack {
                                    Text("Trailer(s)")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .padding()
                                    Spacer()
                                }
                                ForEach(youtubeTrailerVideos) { video in
                                    YouTubeView(videoKey: video.key)
                                        .aspectRatio(16/9, contentMode: .fit)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                }
                            }
                            
                        }
                    }
                }
            }
            .onAppear {
                self.movieDetailViewModel.fetchMovie(id: self.movieId)
        }
        }
    }
}

#Preview {
    MovieDetailView(movieId: Movie.stubbedMovie.id)
}
