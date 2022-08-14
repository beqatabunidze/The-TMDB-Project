//
//  FavouritesViewModel.swift
//  The TMDB Project
//
//  Created by Beqa Tabunidze on 13.08.22.
//

import Foundation
import RxSwift
import RxCocoa

protocol FavouritesViewModelProtocol {
    var movies: [Movie] { get set}
    var navigateToDetailReady: BehaviorRelay<MovieDetailViewModel?> { get set }
    
    func navigateToDetail(id: Int)
    func retriveFavourites()
}

final class FavouritesViewModel: FavouritesViewModelProtocol {

    // MARK: - Properties
    var movies: [Movie] = []
    var navigateToDetailReady = BehaviorRelay<MovieDetailViewModel?>(value: nil)
    

    func retriveFavourites() {
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.value(forKey: "favourites") as? Data {
            let movie = try? PropertyListDecoder().decode([Movie].self, from: data)
            guard let movie = movie else { return }
            self.movies = movie
            print(movie)
        } else {
            print("error")
        }
    }
    
    func navigateToDetail(id: Int) {
        let detailViewModel = MovieDetailViewModel()
        detailViewModel.movieIdDatasource.accept(id)
        navigateToDetailReady.accept(detailViewModel)
    }
}
