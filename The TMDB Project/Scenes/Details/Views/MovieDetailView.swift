//
//  MovieDetailView.swift
//  The TMDB Project
//
//  Created by Beqa Tabunidze on 13.08.22.
//

import UIKit

final class MovieDetailView: UIView {
    
    // MARK: - scrollView
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    // MARK: - topView
    private lazy var posterImageView: UIImageView = {
        let posterImageView = UIImageView.create(image: UIImage(named: "movie"))
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.layer.borderColor = UIColor(white: 0, alpha: 0.7).cgColor
        posterImageView.layer.borderWidth = 2
        posterImageView.layer.cornerRadius = 3
        posterImageView.roundCorners(with: 10, borderColor: .label, borderWidth: 1.0)
        return posterImageView
    }()
    
    private lazy var foregroundPosterImageView: UIImageView = {
        let foregroundPoster = UIImageView.create(image: UIImage(named: "movie"))
//        foregroundPoster.roundCorners(with: 30, borderColor: .darkGray, borderWidth: 1.0)
        foregroundPoster.blurView.setup(style: UIBlurEffect.Style.dark, alpha: 0.7).enable()
        return foregroundPoster
    }()
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.sizeAnchor(height: 400)
        view.addSubviews(foregroundPosterImageView, posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        posterImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        foregroundPosterImageView.translatesAutoresizingMaskIntoConstraints = false
        foregroundPosterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        foregroundPosterImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()
    
    // MARK: - midView
    private lazy var movieTitleLabel: UILabel = {
        let movieTitleLabel = UILabel.create(font: .systemFont(ofSize: 16.0, weight: .semibold),
                                             textColor: .label, textAlignment: .center)
        movieTitleLabel.text = "movie name"
        movieTitleLabel.sizeToFit()
        movieTitleLabel.lineBreakMode = .byTruncatingTail
        return movieTitleLabel
    }()
    private lazy var titleStackView: UIStackView = .create(arrangedSubViews: [movieTitleLabel])
    
    private lazy var releaseDateFixedLabel: UILabel = .create(text: "Release Date:", font: .systemFont(ofSize: 12.0),
                                                              textColor: .systemGreen, textAlignment: .center)
    private lazy var releaseDateLabel: UILabel = .create(text: "releaseDateLabel", font: .systemFont(ofSize: 12.0),
                                                         textColor: .label, textAlignment: .center)
    private lazy var dateStackView: UIStackView = .create(arrangedSubViews: [releaseDateFixedLabel, releaseDateLabel],
                                                          spacing: 2)
    
    private lazy var averageVoteFixedLabel: UILabel = .create(text: "Rating:", font: .systemFont(ofSize: 12.0),
                                                              textColor: .systemRed, textAlignment: .center)
    private lazy var ratingLabel: UILabel = .create(text: "ratingLabel", font: .systemFont(ofSize: 12.0),
                                                    textColor: .label, textAlignment: .center)
    private lazy var voteStackView: UIStackView = .create(arrangedSubViews: [averageVoteFixedLabel, ratingLabel],
                                                          spacing: 2)
    
    private lazy var midView: UIView = {
        let view = UIView()
        let midStackView: UIStackView = .create(arrangedSubViews: [dateStackView, titleStackView,voteStackView],
                                                axis: .horizontal, alignment: .center,
                                                distribution: .fillEqually, spacing: 4.0)
        view.addSubview(midStackView)
        midStackView.fillSuperview()
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    // MARK: - movieDescriptionView
    private lazy var movieDescriptionLabel: UILabel = {
        let movieDescriptionLabel = UILabel.create(text: "", font: .systemFont(ofSize: 14.0, weight: .semibold), textColor: .label)
        movieDescriptionLabel.sizeToFit()
        movieDescriptionLabel.fillSuperview(with: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        return movieDescriptionLabel
    }()
    private lazy var descriptionStackView: UIStackView = .create(arrangedSubViews: [movieDescriptionLabel])
    
    // MARK: - castCollectionViewLabel
    private lazy var castCollectionViewLabel: UILabel = {
        let castCollectionViewLabel = UILabel.create(text: "Movie Cast", font: .systemFont(ofSize: 16.0, weight: .bold),
                                                     textColor: .label, textAlignment: .left)
        castCollectionViewLabel.sizeToFit()
        castCollectionViewLabel.fillSuperview(with: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        return castCollectionViewLabel
    }()
    private lazy var castCollectionViewLabelStackView: UIStackView = .create(arrangedSubViews: [castCollectionViewLabel])
    
    // MARK: - castCollectionView
    lazy var castCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CastCollectionViewCell.self,
                                forCellWithReuseIdentifier: CastCollectionViewCell.viewIdentifier)
        return collectionView
    }()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150,
                                 height: 150)
        layout.minimumInteritemSpacing = 8.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 4.0, bottom: 0, right: 4.0)
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    // MARK: - allStackView
    // TODO Question why distribution didn't work properly when I set it to fill?
    private lazy var allStackView: UIStackView = .create(arrangedSubViews: [topView, midView,
                                                                            .createSeparator(with: .horizontal,
                                                                                             backgroundColor: .lightGray),
                                                                            descriptionStackView,
                                                                            .createSeparator(with: .horizontal,
                                                                                             backgroundColor: .lightGray),
                                                                            castCollectionViewLabelStackView,
                                                                            castCollectionView],
                                                         distribution: .equalSpacing, spacing: 12)
    
    // MARK: - Initilizations
    init() {
        super.init(frame: .zero)
        arrangeViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
private extension MovieDetailView {
    func arrangeViews() {
        backgroundColor = .secondarySystemBackground
        castCollectionView.backgroundColor = .secondarySystemBackground
        setupScrollView()
        contentView.addSubview(allStackView)
        allStackView.fillSuperview()
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.widthAnchor.constraint(equalTo: allStackView.widthAnchor).isActive = true
        foregroundPosterImageView.translatesAutoresizingMaskIntoConstraints = false
        foregroundPosterImageView.widthAnchor.constraint(equalTo: topView.widthAnchor).isActive = true
        foregroundPosterImageView.heightAnchor.constraint(equalTo: topView.heightAnchor).isActive = true
        
        castCollectionView.translatesAutoresizingMaskIntoConstraints = false
        castCollectionView.widthAnchor.constraint(equalTo: allStackView.widthAnchor).isActive = true
        castCollectionView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
}

extension MovieDetailView {
    func populateUI(posterImageViewURL: URL?, foregroundPosterImageViewURL: URL?, movieTitle: String,
                    releaseDate: String, rating: Double, movieDescription: String){
        if let posterImageViewURL = posterImageViewURL {
            
            posterImageView.kf.setImage(with: posterImageViewURL)
        } else{
            posterImageView.image = UIImage(named: "person")
        }
        
        if let foregroundPosterImageViewURL = foregroundPosterImageViewURL {
            foregroundPosterImageView.kf.setImage(with: foregroundPosterImageViewURL)
        } else {
            foregroundPosterImageView.image = UIImage(named: "person")
        }
        
        movieTitleLabel.text = movieTitle
        releaseDateLabel.text = releaseDate
        ratingLabel.text = String(rating)
        movieDescriptionLabel.text = movieDescription
        invalidateIntrinsicContentSize()
    }
}
