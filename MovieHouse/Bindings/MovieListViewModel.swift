//
//  MovieListViewModel.swift
//  MovieHouse
//
//  Created by Nitish Jain on 04/10/24.
//

import Foundation

class MovieListViewModel: ObservableObject {
    
    @Published var movies: [Movie]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private let movieService: MovieService
    
    init(movieService: MovieService = MovieCommunicator.shared) {
        self.movieService = movieService
    }
    
    func loadMovies(with endpoint: MovieListEndpoint) {
        movies = nil
        isLoading = true
        error = nil
        
        movieService.fetchMovies(from: endpoint) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let response):
                    self.movies = response.results
                case .failure(let error):
                    self.error = error as NSError
            }
            isLoading = false
        }
    }
}
