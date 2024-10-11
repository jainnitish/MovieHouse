//
//  MovieListView.swift
//  MovieHouse
//
//  Created by Nitish Jain on 04/10/24.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject private var nowPlayingState = MovieListViewModel()
    @ObservedObject private var upcomingState = MovieListViewModel()
    @ObservedObject private var topRatedState = MovieListViewModel()
    @ObservedObject private var popularState = MovieListViewModel()
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Text("Movie House")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top, 20)
                            .foregroundColor(.red)
                        Spacer()
                    }
                    
                    Group {
                        if let npMovies = nowPlayingState.movies {
                            MoviePosterCarouselView(title: "Now Playing", movies: npMovies)
                                .environmentObject(router)
                        } else {
                            LoadingIndicatorView(isLoading: nowPlayingState.isLoading, error: nowPlayingState.error) {
                                self.nowPlayingState.loadMovies(with: .nowPlaying)
                            }
                        }
                    }
                    .padding(.vertical, 12)
                    
                    Group {
                        if let ucMovies = upcomingState.movies {
                            MoviePosterCarouselView(title: "Upcoming", movies: ucMovies)
                                .environmentObject(router)
                        } else {
                            LoadingIndicatorView(isLoading: upcomingState.isLoading, error: upcomingState.error) {
                                self.upcomingState.loadMovies(with: .upcoming)
                            }
                        }
                    }
                    .padding(.vertical, 12)
                    
                    Group {
                        if let trMovies = topRatedState.movies {
                            MoviePosterCarouselView(title: "Top Rated", movies: trMovies)
                                .environmentObject(router)
                        } else {
                            LoadingIndicatorView(isLoading: topRatedState.isLoading, error: topRatedState.error) {
                                self.topRatedState.loadMovies(with: .topRated)
                            }
                        }
                    }
                    .padding(.vertical, 12)
                    
                    Group {
                        if let ppMovies = popularState.movies {
                            MoviePosterCarouselView(title: "Popular", movies: ppMovies)
                                .environmentObject(router)
                        } else {
                            LoadingIndicatorView(isLoading: popularState.isLoading, error: popularState.error) {
                                self.popularState.loadMovies(with: .popular)
                            }
                        }
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 30)
                }
            }
            .onAppear {
                self.nowPlayingState.loadMovies(with: .nowPlaying)
                self.upcomingState.loadMovies(with: .upcoming)
                self.topRatedState.loadMovies(with: .topRated)
                self.popularState.loadMovies(with: .popular)
            }
        }
    }
}
        
        
//        NavigationView {
//            List {
//                Group {
//                    if let npMovies = nowPlayingState.movies {
//                        MoviePosterCarouselView(title: "Now Playing", movies: npMovies)
//                    } else {
//                        LoadingIndicatorView(isLoading: nowPlayingState.isLoading, error: nowPlayingState.error) {
//                            self.nowPlayingState.loadMovies(with: .nowPlaying)
//                        }
//                    }
//                }
//                .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0))
//                
//                Group {
//                    if let ucMovies = upcomingState.movies {
//                        MovieBackdropCarouselView(title: "Upcoming", movies: ucMovies)
//                    } else {
//                        LoadingIndicatorView(isLoading: upcomingState.isLoading, error: upcomingState.error) {
//                            self.upcomingState.loadMovies(with: .upcoming)
//                        }
//                    }
//                }
//                
//                Group {
//                    if let trMovies = topRatedState.movies {
//                        MovieBackdropCarouselView(title: "Top Rated", movies: trMovies)
//                    } else {
//                        LoadingIndicatorView(isLoading: topRatedState.isLoading, error: topRatedState.error) {
//                            self.topRatedState.loadMovies(with: .topRated)
//                        }
//                    }
//                }
//                
//                Group {
//                    if let ppMovies = popularState.movies {
//                        MovieBackdropCarouselView(title: "Popular", movies: ppMovies)
//                    } else {
//                        LoadingIndicatorView(isLoading: popularState.isLoading, error: popularState.error) {
//                            self.popularState.loadMovies(with: .popular)
//                        }
//                    }
//                }
//            }
//            .listStyle(.grouped)
//            .navigationTitle("Movie House")
//        }
//        .onAppear {
//            self.nowPlayingState.loadMovies(with: .nowPlaying)
//            self.upcomingState.loadMovies(with: .upcoming)
//            self.topRatedState.loadMovies(with: .topRated)
//            self.popularState.loadMovies(with: .popular)
//        }
//    }

#Preview {
    MovieListView()
        .environmentObject(Router())
}
