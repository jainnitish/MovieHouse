//
//  MovieDetailViewModel.swift
//  MovieHouse
//
//  Created by Nitish Jain on 05/10/24.
//

import SwiftUI

class MovieDetailViewModel: ObservableObject {
    
    private let movieService: MovieService
    @Published var movie: Movie?
    @Published var isLoading = false
    @Published var error: NSError?
    
    init(movieService: MovieService = MovieCommunicator.shared) {
        self.movieService = movieService
    }
    
    func fetchMovie(id: Int) {
        self.movie = nil
        self.isLoading = true
        self.movieService.fetchMovie(from: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movie):
                self.movie = movie
                self.isLoading = false
            case .failure(let error):
                self.error = error as NSError
                self.isLoading = false
            }
        }
    }
    
}
