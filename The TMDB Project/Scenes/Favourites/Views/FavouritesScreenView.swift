//
//  FavouritesScreenView.swift
//  The TMDB Project
//
//  Created by Beqa Tabunidze on 13.08.22.
//

import Foundation
import UIKit

final class FavouritesScreenView: UIView {
    
    // MARK: - Table View
    lazy var tableView: UITableView = {
        let tableView = UITableView.create(estimatedRowHeight: 72)
        tableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.viewIdentifier)
        return tableView
    }()
    
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
private extension FavouritesScreenView {
    func arrangeViews() {
        backgroundColor = .secondarySystemBackground
        addSubview(tableView)
        tableView.fillSuperview()
    }
}
