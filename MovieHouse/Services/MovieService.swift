//
//  MovieService.swift
//  MovieHouse
//
//  Created by Nitish Jain on 03/10/24.
//

import Foundation

protocol MovieService {
    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> Void)
    func fetchMovie(from id: Int, completion: @escaping (Result<Movie, MovieError>) -> Void)
    func SearchMovies(with query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> Void)
}

enum MovieListEndpoint: String {
    case nowPlaying = "now_playing"
    case upcoming
    case topRated = "top_rated"
    case popular
    
    var description: String {
        switch self {
            case .nowPlaying: return "Now Playing"
            case .upcoming: return "Upcoming"
            case .topRated: return "Top Rated"
            case .popular: return "Popular"
        }
    }
}

enum MovieError: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case noData
    case invalidResponse
    case serializationError
    
    var localizedDescription: String {
        switch self {
            case .apiError: return "Failed to fetch data"
            case .invalidEndpoint: return "Invalid Endpoint"
            case .noData: return "No Data"
            case .invalidResponse: return "Invalid Response"
            case .serializationError: return "Failed to Parse Data"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}



