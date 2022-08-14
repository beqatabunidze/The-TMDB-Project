//
//  Movie.swift
//  The TMDB Project
//
//  Created by Beqa Tabunidze on 13.08.22.
//

import Foundation

// MARK: - Movie
struct Movie: Encodable, Decodable {
    let id: Int
    let originalTitle: String?
    let posterPath: String?
    let video: Bool?
    let title, overview, releaseDate: String?
    let voteAverage: Double?
    let adult: Bool?
    let backdropPath: String?
    let voteCount: Int?
    let genreIDS: [Int]?
    let popularity: Double?
    let character: String?
    let creditID: String?
    let order: Int?
    let department, job: String?

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case video, title, overview
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case adult
        case backdropPath = "backdrop_path"
        case voteCount = "vote_count"
        case genreIDS = "genre_ids"
        case popularity, character
        case creditID = "credit_id"
        case order, department, job
    }
}
// MARK: - MovieDetail
struct MovieDetail: Decodable {
    let backdropPath: String?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let revenue, runtime: Int?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Genre
struct Genre: Decodable {
    let id: Int?
    let name: String?
}

