//
//  MovieDetailBuilder.swift
//  The TMDB Project
//
//  Created by Beqa Tabunidze on 13.08.22.
//

import Foundation

final class MovieDetailBuilder {
    
    static func make(with viewModel: MovieDetailViewModel) -> MovieDetailViewController {
        let viewController = MovieDetailViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
