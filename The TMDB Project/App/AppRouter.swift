//
//  AppRouter.swift
//  The TMDB Project
//
//  Created by Beqa Tabunidze on 12.08.22.
//

import UIKit

final class AppRouter {
    
    func start(window: UIWindow) {
        let viewController = MainScreenBuilder.make(with: MovieViewModel())
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
