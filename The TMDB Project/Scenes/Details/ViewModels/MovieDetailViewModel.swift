//
//  MovieDetailViewModel.swift
//  The TMDB Project
//
//  Created by Beqa Tabunidze on 13.08.22.
//

import Foundation
import RxSwift
import RxCocoa

protocol MovieDetailViewModelProtocol {
    var movieIdDatasource: BehaviorRelay<Int?> { get set }
    var movieDetailDatasource: BehaviorRelay<Movie?> { get set }
    var movieCreditsDatasource: BehaviorRelay<[Cast?]> { get set }
    var isLoading: BehaviorRelay<Bool> { get set }
    var onError: BehaviorRelay<Bool> { get set }
    
    func getMovieDetails(movieId: Int)
    func getMovieCredits(movieId: Int)
    func saveMovieToFavourites(movie: Movie)
}

final class MovieDetailViewModel: MovieDetailViewModelProtocol, MovieDetailAPIProtocol {
    
    // MARK: - Properties
    private var bag = DisposeBag()
    
    var isLoading = BehaviorRelay<Bool>(value: false)
    var onError = BehaviorRelay<Bool>(value: false)
    var movieIdDatasource = BehaviorRelay<Int?>(value: nil)
    var movieDetailDatasource = BehaviorRelay<Movie?>(value: nil)
    var movieCreditsDatasource = BehaviorRelay<[Cast?]>(value: [nil])
    var movies: [Movie] = UserDefaults.standard.array(forKey: "favourites") as? [Movie] ?? []
    
    
    func getMovieDetails(movieId: Int) {
        Observable.just((movieId))
            .do( onNext: { [isLoading] _ in
                isLoading.accept(true)
            })
            .flatMap { movieId in
                self.getMovieDetails(movieId: movieId)
            }
            .observe(on: MainScheduler.instance)
            .do(onError: { _ in self.onError.accept(true) })
            .do(onDispose: { [isLoading] in isLoading.accept(false) })
            .subscribe(onNext: { [weak self] movie in
                self?.updateMovieDetailDatasource(with: movie)
            })
            .disposed(by: bag)
    }

    func getMovieCredits(movieId: Int) {
        Observable.just((movieId))
            .do( onNext: { [isLoading] _ in
                isLoading.accept(true)
            })
            .flatMap { movieId in
                self.getMovieCredits(movieId: movieId)
            }
            .observe(on: MainScheduler.instance)
            .do(onError: { _ in self.onError.accept(true) })
            .do(onDispose: { [isLoading] in isLoading.accept(false) })
            .subscribe(onNext: { [weak self] movieCreditsResponse in
                self?.updateMovieCreditsDatasource(with: movieCreditsResponse.cast)
            })
            .disposed(by: bag)
    }

    func saveMovieToFavourites(movie: Movie) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(try? PropertyListEncoder().encode(movie), forKey: "favourite")
        
        if let data = userDefaults.value(forKey: "favourite") as? Data {
            let savedMovie = try? PropertyListDecoder().decode(Movie.self, from: data)
            guard let savedMovie = savedMovie else { return }
            self.movies = UserDefaults.standard.array(forKey: "favourites") as? [Movie] ?? []
            self.movies.append(savedMovie)
            print(self.movies, "appended")
            userDefaults.set(try? PropertyListEncoder().encode(self.movies), forKey: "favourites")
            
        } else {
            print("error")
        }

    }
}

//MARK: - Helper Methods
extension MovieDetailViewModel {
    
    private func updateMovieCreditsDatasource(with movieCredits: [Cast?]) {
        self.movieCreditsDatasource.accept(movieCredits)
    }
    
    private func updateMovieDetailDatasource(with movie: Movie) {
        self.movieDetailDatasource.accept(movie)
    }
    
}

