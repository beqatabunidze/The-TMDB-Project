//
//  UIImageView+Extension.swift
//  The TMDB Project
//
//  Created by Beqa Tabunidze on 13.08.22.
//

import Foundation
import UIKit
import Kingfisher

// MARK: - UIImageView Extension
extension UIImageView {
    func setImage(with url: String?, placeholder: UIImage? = nil, errorImage: UIImage? = nil) {
        guard let urlString = url else {return}
        guard let url = URL(string: urlString) else {return}
        self.kf.setImage(with: url, placeholder: placeholder, completionHandler:  { result in
            switch result {
            case .success(let value):
                self.image = value.image
                self.clipsToBounds = true
            case .failure(_):
                self.image = errorImage
            }
        })
    }
    
    func setImage(with url: URL, placeholder: UIImage? = nil, errorImage: UIImage? = nil) {
        self.kf.setImage(with: url, placeholder: placeholder, completionHandler:  { result in
            switch result {
            case .success(let value):
                self.image = value.image
                self.clipsToBounds = true
            case .failure(_):
                self.image = errorImage
            }
        })
    }
}

extension UIImageView {
    static func create(image: UIImage? = nil,
                       contentMode: ContentMode = .scaleToFill,
                       isUserInteractionEnabled: Bool = false,
                       cornerRadius: CGFloat? = nil,
                       backgroundColor: UIColor? = nil,
                       tintColor: UIColor? = nil,
                       clipsToBounds: Bool = false) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = contentMode
        imageView.isUserInteractionEnabled = isUserInteractionEnabled
        if let cornerRadius = cornerRadius {
            imageView.roundCorners(with: cornerRadius)
        }
        imageView.backgroundColor = backgroundColor
        imageView.tintColor = tintColor
        imageView.clipsToBounds = clipsToBounds
        return imageView
    }
}
