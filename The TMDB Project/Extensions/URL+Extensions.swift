//
//  URL+Extensions.swift
//  The TMDB Project
//
//  Created by Beqa Tabunidze on 13.08.22.
//

import Foundation

enum Endpoints {
    static let apiKey = "896dd63ac40d11a5db36bd7128e25a7f"
    static let base = "https://api.themoviedb.org/3"
    static let apiKeyParam = "?api_key=\(apiKey)"
}

extension URL {
    
    static func getPopularMovies(page: Int) -> URL? {
        URL(string: Endpoints.base + "/movie/popular" + Endpoints.apiKeyParam + "&page=\(page)")
    }
    
    static func getMovieDetails(id: Int) -> URL? {
        URL(string: Endpoints.base + "/movie/\(id)" + Endpoints.apiKeyParam)
    }
    
    static func getMovieCredits(id: Int) -> URL? {
        URL(string: Endpoints.base + "/movie/\(id)" + "/credits" + Endpoints.apiKeyParam)
    }
    
    static func posterImage(posterPath: String) -> URL? {
        URL(string: "https://image.tmdb.org/t/p/w200/" + posterPath)
    }
    
}
