//
//  Movie.swift
//  MovieHouse
//
//  Created by Nitish Jain on 03/10/24.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable, Identifiable {
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int?
    let releaseDate: String?
    let genres: [MovieGenre]?
    let credits: Credits?
    let videos: MovieVideos?
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static private let timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
    var backdropURL: URL {
        URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    var posterURL: URL {
        URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    var genreText: String {
        genres?.first?.name ?? "n/a"
    }
    
    var ratingText: String {
        let rating = Int(voteAverage)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }
    
    var scoreText: String {
        guard ratingText.count > 0 else {
            return "n/a"
        }
        return "\(voteAverage)"
    }
    
    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return Movie.yearFormatter.string(from: date)
    }
    
    var durationText: String {
        guard let runtime = self.runtime, runtime > 0 else {
            return "n/a"
        }
        return Movie.timeFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }
}

struct MovieGenre: Decodable {
    let name: String
}

struct Credits: Decodable {
    let cast: [Artist]
    let crew: [Crew]
}

struct Artist: Decodable, Identifiable {
    var id: Int
    let name: String
    let order: Int
    let profilePath: String?
    
    var profilePathURL: URL? {
        guard let profilePath = profilePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)")
    }
}

struct Crew: Decodable, Identifiable {
    var id: Int
    let name: String
    let job: String
    let profilePath: String?
    
    var profilePathURL: URL? {
        guard let profilePath = profilePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)")
    }
}

struct MovieVideos: Decodable {
    let results: [MovieVideo]
}

struct MovieVideo: Decodable, Identifiable {
    let id: String
    let name: String
    let key: String
    let site: String
    let type: String
    
    var isYoutubeTrailerVideo: Bool {
        site.lowercased() == "youtube" && type.lowercased() == "trailer"
    }
}

enum CodingKeys: String, CodingKey {
    case profilePath = "profile_path"
}
