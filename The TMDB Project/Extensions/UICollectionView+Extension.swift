//
//  UICollectionView+Extension.swift
//  The TMDB Project
//
//  Created by Beqa Tabunidze on 13.08.22.
//

import Foundation
import UIKit

extension UICollectionView {
    func dequeue<T: ViewIdentifier>(at indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableCell(
                withReuseIdentifier: T.viewIdentifier,
                for: indexPath
            ) as? T
        else {
            fatalError("can not deque cell identifier \(T.viewIdentifier) from collectionView \(self)")
        }
        return cell
    }
}
// MARK: - Create UICollectionViewFlowLayout
extension UICollectionViewFlowLayout {
    static func create(itemSize: CGSize = .zero,
                       scrollDirection: UICollectionView.ScrollDirection = .horizontal,
                       interItemSpacing: CGFloat = .leastNormalMagnitude,
                       lineSpacing: CGFloat = .leastNormalMagnitude,
                       sectionInset: UIEdgeInsets = .zero) -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        layout.itemSize = itemSize
        layout.minimumInteritemSpacing = interItemSpacing
        layout.minimumLineSpacing = lineSpacing
        layout.sectionInset = sectionInset
        layout.invalidateLayout()
        return layout
    }
}
