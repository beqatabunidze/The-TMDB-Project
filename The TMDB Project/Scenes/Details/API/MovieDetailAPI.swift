//
//  MovieDetailAPI.swift
//  The TMDB Project
//
//  Created by Beqa Tabunidze on 13.08.22.
//

import Foundation
import RxSwift

protocol MovieDetailAPIProtocol { }

extension MovieDetailAPIProtocol {
    func getMovieDetails(movieId: Int) -> Observable<Movie> {
        guard let url = URL.getMovieDetails(id: movieId) else { return .empty() }
        return URLRequest.load(resource: Resource<Movie>(url: url))

    }

    func getMovieCredits(movieId: Int) -> Observable<CastResults> {
        guard let url = URL.getMovieCredits(id: movieId) else { return .empty() }
        return URLRequest.load(resource: Resource<CastResults>(url: url))
        
    }
}
