//
//  UIStackView+Extensions.swift
//  The TMDB Project
//
//  Created by Beqa Tabunidze on 13.08.22.
//

import UIKit

public extension UIStackView {
    static func create(
        arrangedSubViews: [UIView] = [],
        axis: NSLayoutConstraint.Axis = .vertical,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill,
        spacing: CGFloat = .leastNormalMagnitude,
        tamic: Bool = true
    ) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubViews)
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = tamic
        return stackView
    }
}
