//
//  CastCollectionViewCell.swift
//  The TMDB Project
//
//  Created by Beqa Tabunidze on 13.08.22.
//

import UIKit

final class CastCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Top View
    private lazy var castMemberImageView: UIImageView = {
        let castMemberImageView = UIImageView.create(image: UIImage(named: "profile"))
        castMemberImageView.sizeAnchor(width: 80, height: 120)
        castMemberImageView.contentMode = .scaleAspectFill
        castMemberImageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        castMemberImageView.layer.borderWidth = 2
        castMemberImageView.layer.cornerRadius = 6
        castMemberImageView.roundCorners(with: 10, borderColor: .darkGray, borderWidth: 1.0)
        return castMemberImageView
    }()
    
    private lazy var castMemberNameLabel: UILabel = {
        let castMemberNameLabel = UILabel.create(numberOfLines: 2, font: .systemFont(ofSize: 12.0,
                                                                                     weight: .semibold),
                                                 textColor: .label, textAlignment: .center)
        castMemberNameLabel.sizeAnchor(height: 25)
        return castMemberNameLabel
    }()
    
    // MARK: - All View
    private lazy var allStackView: UIStackView = .create(arrangedSubViews: [castMemberImageView,
                                                                            castMemberNameLabel],
                                                         distribution: .equalSpacing, spacing: 4)
    
    // MARK: - Initialization
    override private init(frame: CGRect) {
        super.init(frame: frame)
        arrangeViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Arrange Views
private extension CastCollectionViewCell {
    func arrangeViews() {
        backgroundColor = .secondarySystemBackground
        roundCorners(with: 12.0, borderColor: .darkGray, borderWidth: 1.0)
        contentView.addSubviews(allStackView)
        allStackView.fillSuperview()
    }
}

// MARK: - Helpers
extension CastCollectionViewCell {
    func populateUI(castMemberImageViewURL: URL?, castMemberCategory: String, castMemberName: String){
        
        if let castMemberImageViewURL = castMemberImageViewURL {
            castMemberImageView.kf.setImage(with: castMemberImageViewURL)
        } else {
            castMemberImageView.image = UIImage(named: "person")
        }
        castMemberNameLabel.text = castMemberName
        invalidateIntrinsicContentSize()
    }
}

