//
//  MovieViewModel.swift
//  The TMDB Project
//
//  Created by Beqa Tabunidze on 13.08.22.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

protocol MovieViewModelProtocol {
    var movieDatasource: BehaviorRelay<[Movie]> { get set }
    var isLoading: BehaviorRelay<Bool> { get set }
    var onError: BehaviorRelay<Bool> { get set }
    var navigateToDetailReady: BehaviorRelay<MovieDetailViewModel?> { get set }
    var navigateToFavouriteReady: BehaviorRelay<FavouritesViewModel?> { get set }

    func getMovieList()
    func navigateToDetail(id: Int)
    func navigateToFavourites()
}

final class MovieViewModel: MovieViewModelProtocol, MainScreenApi {

    // MARK: - Properties
    private var currentPage: Int = 1
    private var bag = DisposeBag()

    var movieDatasource = BehaviorRelay<[Movie]>(value: [])
    var isLoading = BehaviorRelay<Bool>(value: false)
    var onError = BehaviorRelay<Bool>(value: false)
    var navigateToDetailReady = BehaviorRelay<MovieDetailViewModel?>(value: nil)
    var navigateToFavouriteReady = BehaviorRelay<FavouritesViewModel?>(value: nil)

    //MARK: - Public Methods
    func getMovieList() {
        if currentPage > 500 {
            return
        }

        Observable.just((currentPage))
            .do(onNext: { [weak self] _ in
                self?.isLoading.accept(true)
                self?.currentPage += 1
            })
            .flatMap { pageNumber in
                self.getMovieList(pageNumber: pageNumber)
            }
            .observe(on: MainScheduler.instance)
            .do(onError: { _ in self.onError.accept(true) })
            .do(onDispose: { [isLoading] in isLoading.accept(false) })
            .subscribe(onNext: { [weak self] movieResponse in
                self?.updateMovieDatasource(with: movieResponse.results)
            })
            .disposed(by: bag)
    }

    func navigateToDetail(id: Int) {
        let detailViewModel = MovieDetailViewModel()
        detailViewModel.movieIdDatasource.accept(id)
        navigateToDetailReady.accept(detailViewModel)
    }
    
    func navigateToFavourites() {
        let favouritesViewModel = FavouritesViewModel()
        navigateToFavouriteReady.accept(favouritesViewModel)
    }
}

//MARK: - Helper Methods
extension MovieViewModel {

    private func updateMovieDatasource(with movies: [Movie]) {
        self.movieDatasource.accept(movieDatasource.value + movies)
    }

}

