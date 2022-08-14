//
//  FavouritesScreenBuilder.swift
//  The TMDB Project
//
//  Created by Beqa Tabunidze on 13.08.22.
//

import Foundation

final class FavouritesScreenBuilder {
    
    static func make(with viewModel: FavouritesViewModel) -> FavouritesViewController {
        let viewController = FavouritesViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
