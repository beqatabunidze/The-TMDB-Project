//
//  MovieListTableViewCell.swift
//  The TMDB Project
//
//  Created by Beqa Tabunidze on 13.08.22.
//

import UIKit

final class MovieListTableViewCell: UITableViewCell {
    
    // MARK: - Top View
    private lazy var movieImage: UIImageView = {
        let movieImageView = UIImageView.create(image: UIImage(named: "movie"))
        movieImageView.contentMode = .scaleAspectFit
        movieImageView.sizeAnchor(width: 120, height: 180)
        movieImageView.layer.borderColor = UIColor.darkGray.cgColor
        movieImageView.layer.borderWidth = 2
        movieImageView.layer.cornerRadius = 3
        return movieImageView
    }()
    
    private lazy var foregroundView: UIView = {
        let foregroundPoster = UIView()
        foregroundPoster.sizeAnchor(width: 400, height: 200)
        foregroundPoster.roundCorners(corners: .allCorners, radius: 20)
        return foregroundPoster
    }()
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.sizeAnchor(height: 200)
        foregroundView.fillSuperview()
        view.addSubviews(foregroundView, movieImage)
        movieImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        movieImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        foregroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        foregroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()
    
    // MARK: - Bottom View
    private lazy var releaseDateFixedLabel: UILabel = .create(text: "Release Date:", font: .systemFont(ofSize: 12.0),
                                                              textColor: .darkOrange, textAlignment: .center)
    private lazy var movieReleaseDateLabel: UILabel = .create(font: .systemFont(ofSize: 12.0), textColor: .darkGray,
                                                              textAlignment: .center)
    private lazy var dateStackView: UIStackView = .create(arrangedSubViews: [releaseDateFixedLabel, movieReleaseDateLabel])
    
    private lazy var movieTitleLabel: UILabel = {
        let movieTitleLabel = UILabel.create(font: .systemFont(ofSize: 16.0, weight: .semibold), textColor: .label,
                                             textAlignment: .center)
        movieTitleLabel.text = "movie name"
        movieTitleLabel.sizeToFit()
        movieTitleLabel.lineBreakMode = .byTruncatingTail
        return movieTitleLabel
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        let bottomStackView: UIStackView = .create(arrangedSubViews: [movieTitleLabel],
                                                   axis: .horizontal, alignment: .center, distribution: .fillEqually,
                                                   spacing: 4.0)
        view.addSubview(bottomStackView)
        bottomStackView.fillSuperview(with: UIEdgeInsets(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0))
        return view
    }()
    
    // MARK: - All View
    private lazy var allStackView: UIStackView = .create(arrangedSubViews: [topView,
                                                                            bottomView, .createSeparator(with: .horizontal,
                                                                                                         backgroundColor: .darkGray)])
    
    // MARK: - Initilizations
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        arrangeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
private extension MovieListTableViewCell {
    func arrangeViews() {
        backgroundColor = .secondarySystemBackground
        contentView.addSubview(allStackView)
        allStackView.fillSuperview()
        roundCorners(with: 20, borderColor: .clear, borderWidth: 2.0)
    }
}

extension MovieListTableViewCell {
    func populateUI(movieImageViewURL: URL?, foregroundPosterImageViewURL: URL?, movieTitle: String,
                    releaseDate: String?, averageVote: Double?){
        
        if let movieImageViewURL = movieImageViewURL {
            movieImage.kf.setImage(with: movieImageViewURL)
        } else{
            movieImage.image = UIImage(named: "movie")
        }
        
        movieTitleLabel.text = movieTitle
        movieReleaseDateLabel.text = releaseDate
        movieReleaseDateLabel.isHidden = releaseDate == nil
        releaseDateFixedLabel.isHidden = releaseDate == nil
        invalidateIntrinsicContentSize()
    }
}

