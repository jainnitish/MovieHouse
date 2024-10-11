//
//  MovieCommunicator.swift
//  MovieHouse
//
//  Created by Nitish Jain on 03/10/24.
//

import Foundation

class MovieCommunicator: MovieService {
    
    static let shared = MovieCommunicator()
    private init() {}
    
    private let apiKey = "b156acef9f4f101df661fc8d75f52b8a"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> Void) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(endpoint.rawValue)") else {
            self.executeCompletionHandlerInMainThread(with: .failure(.invalidEndpoint), completion: completion)
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchMovie(from id: Int, completion: @escaping (Result<Movie, MovieError>) -> Void) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)") else {
            self.executeCompletionHandlerInMainThread(with: .failure(.invalidEndpoint), completion: completion)
            return
        }
        self.loadURLAndDecode(url: url, params: [
            "append_to_response": "videos,credits"
        ], completion: completion)
    }
    
    func SearchMovies(with query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> Void) {
        guard let url = URL(string: "\(baseAPIURL)/search/movie") else {
            self.executeCompletionHandlerInMainThread(with: .failure(.invalidEndpoint), completion: completion)
            return
        }
        self.loadURLAndDecode(url: url, params: [
            "language": "en-US",
            "include_adult": "true",
            "region": "US",
            "query": query
        ], completion: completion)
    }
    
    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, MovieError>) -> Void) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var request = URLRequest(url: finalURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        urlSession.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if error != nil {
                self.executeCompletionHandlerInMainThread(with: .failure(.apiError), completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let decodeResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionHandlerInMainThread(with: .success(decodeResponse), completion: completion)
            } catch {
                self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
                return
            }
        }.resume()
    }
    
    private func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D, MovieError>, completion: @escaping (Result<D, MovieError>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
