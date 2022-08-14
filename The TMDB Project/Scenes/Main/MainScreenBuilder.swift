//
//  MainScreenBuilder.swift
//  The TMDB Project
//
//  Created by Beqa Tabunidze on 13.08.22.
//

import UIKit

final class MainScreenBuilder {
    
    static func make(with viewModel: MovieViewModel) -> MainViewController {
        let viewController = MainViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
