//
//  MainViewController.swift
//  The TMDB Project
//
//  Created by Beqa Tabunidze on 13.08.22.
//

import UIKit
import RxSwift
import RxCocoa

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    private let bag = DisposeBag()
    private var mainScreenView = MainScreenView()
    var viewModel: MovieViewModelProtocol?
    var starImage = UIImage(systemName: "star.fill")
    
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
        observeDataSource()
        loadMoreMovies()
        mainScreenView.tableView.restore()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideKeyboardWhenTappedAround()
    }
    
    @objc func onTapFavourites() {
        viewModel?.navigateToFavourites()
    }
}

//  MARK: - Arrange Views
extension MainViewController {
    func arrangeViews() {
        view = mainScreenView
        title = "Movies"
        
        self.navigationController?.navigationBar.tintColor = UIColor(named: "tintColour")
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        starImage = starImage?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: starImage, style:.plain, target: self, action: #selector(onTapFavourites))

        mainScreenView.tableView.delegate = self
        mainScreenView.tableView.dataSource = self
    }
}

// MARK: - Observe Data Source
extension MainViewController {
    func observeDataSource() {
        guard let viewModel = viewModel else { return }
        
        viewModel.movieDatasource.subscribe(onNext: { [weak self] data in
            guard let self = self else { return }
            self.mainScreenView.tableView.reloadData()
        }).disposed(by: bag)
        
        viewModel.navigateToDetailReady
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] detailViewModel in
                let detailViewController = MovieDetailBuilder.make(with: detailViewModel)
                self?.navigationController?.pushViewController(detailViewController, animated: true)
            })
            .disposed(by: bag)
        
        viewModel.navigateToFavouriteReady
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] favouritesViewModel in
                let favouritesViewController = FavouritesScreenBuilder.make(with: favouritesViewModel)
                self?.navigationController?.pushViewController(favouritesViewController, animated: true)
            })
            .disposed(by: bag)
        
        viewModel.isLoading.asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLoading in
                if isLoading {
                    self?.startLoading()
                } else {
                    self?.stopLoading()
                }
            })
            .disposed(by: bag)
        
        viewModel.onError.asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] onError in
                if onError {
                    self?.showAlertController()
                }
            })
            .disposed(by: bag)
    }
    
    func loadMoreMovies(){
        viewModel?.getMovieList()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let viewModel = viewModel else { return }
        
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height )
                && viewModel.isLoading.value != true){
            self.loadMoreMovies()
        }
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return .zero }
        
        return viewModel.movieDatasource.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        let cell: MovieListTableViewCell = tableView.deque(at: indexPath)
        let movie = viewModel.movieDatasource.value[indexPath.row]
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
        let movie = viewModel.movieDatasource.value[indexPath.row]
        viewModel.navigateToDetail(id: movie.id)
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension UIBarButtonItem {
    func addTargetForAction(target: AnyObject, action: Selector) {
        self.target = target
        self.action = action
    }
}

