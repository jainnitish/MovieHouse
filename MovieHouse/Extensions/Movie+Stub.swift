//
//  Movie+Stub.swift
//  MovieHouse
//
//  Created by Nitish Jain on 03/10/24.
//

import Foundation

extension Movie {
    
    static var stubbedMovies: [Movie] {
        let response: MovieResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "movie_list")
        return response!.results
    }
    
    static var stubbedMovie: Movie {
        stubbedMovies[0]
    }
}

extension Bundle {
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else { return nil }
        let data = try Data(contentsOf: url)
        let decodedModel = try Utils.jsonDecoder.decode(D.self, from: data)
        return decodedModel
    }
}
