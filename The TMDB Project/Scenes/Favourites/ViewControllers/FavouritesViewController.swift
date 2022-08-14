//
//  FavouritesViewController.swift
//  The TMDB Project
//
//  Created by Beqa Tabunidze on 14.08.22.
//

import Foundation
import UIKit
import RxSwift

final class FavouritesViewController: UIViewController {

    // MARK: - Properties
    private let bag = DisposeBag()
    private var favouritesScreenView = FavouritesScreenView()
    var viewModel: FavouritesViewModelProtocol?
    
    // MARK: - Initilizations
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        arrangeViews()
        favouritesScreenView.tableView.restore()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideKeyboardWhenTappedAround()
    }
}

//  MARK: - Arrange Views
extension FavouritesViewController {
    func arrangeViews() {
        view = favouritesScreenView
        title = "Favourites"
        
        viewModel?.retriveFavourites()
        
        self.navigationController?.navigationBar.tintColor = UIColor(named: "tintColour")
        self.navigationController?.navigationBar.prefersLargeTitles = true

        favouritesScreenView.tableView.delegate = self
        favouritesScreenView.tableView.dataSource = self
        favouritesScreenView.tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension FavouritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return .zero }
        
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        let cell: MovieListTableViewCell = tableView.deque(at: indexPath)
        let movie = viewModel.movies[indexPath.row]
        let movieTitle = movie.title.orEmpty
        let posterPath = movie.posterPath
        let movieImageViewURL = URL.posterImage(posterPath: posterPath.orEmpty)
        let foregroundPosterPath = movie.backdropPath
        let foregroundPosterImageViewURL = URL.posterImage(posterPath: foregroundPosterPath.orEmpty)
        let releaseDate = String(movie.releaseDate?.prefix(4) ?? "")
        let averageVote = movie.voteAverage ?? .zero
        cell.populateUI(movieImageViewURL: movieImageViewURL, foregroundPosterImageViewURL: foregroundPosterImageViewURL,
                            movieTitle: movieTitle,
                            releaseDate: releaseDate, averageVote: averageVote)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let viewModel = viewModel else { return }
        let movie = viewModel.movies[indexPath.row]
        viewModel.navigateToDetail(id: movie.id)
    }
}

// MARK: - UITableViewDelegate
extension FavouritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

