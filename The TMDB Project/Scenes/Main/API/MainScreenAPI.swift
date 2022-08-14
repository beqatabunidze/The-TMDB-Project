//
//  MainScreenAPI.swift
//  The TMDB Project
//
//  Created by Beqa Tabunidze on 13.08.22.
//

import Foundation
import RxSwift

protocol MainScreenApi { }

extension MainScreenApi {
    func getMovieList(pageNumber: Int) -> Observable<MovieResults> {
        guard let url = URL.getPopularMovies(page: pageNumber) else { return .empty() }
        return URLRequest.load(resource: Resource<MovieResults>(url: url))
    }
}
