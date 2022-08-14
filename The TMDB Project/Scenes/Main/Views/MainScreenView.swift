//
//  MainScreenView.swift
//  The TMDB Project
//
//  Created by Beqa Tabunidze on 13.08.22.
//

import Foundation
import UIKit

final class MainScreenView: UIView {
    
    // MARK: - Table View
    lazy var tableView: UITableView = {
        let tableView = UITableView.create(estimatedRowHeight: 72)
        tableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.viewIdentifier)
        return tableView
    }()
    
    var barButton: UIBarButtonItem {
        let barButton: UIButton = UIButton(frame: CGRect(x:0, y:0, width:35, height:35))
        barButton.setTitleColor(UIColor.white, for: .normal)
        barButton.contentMode = .right
        barButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        let backBarButton: UIBarButtonItem = UIBarButtonItem(customView: barButton)
        return backBarButton
    }
    
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
private extension MainScreenView {
    func arrangeViews() {
        backgroundColor = .secondarySystemBackground
        addSubview(tableView)
        tableView.fillSuperview()
    }
}

