//
//  UITableView+Extension.swift
//  The TMDB Project
//
//  Created by Beqa Tabunidze on 13.08.22.
//

import Foundation
import UIKit

// MARK: - Custom Empty View
extension UITableView {
    func setEmptyView(title: String, message: String){
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        let imageView = UIImageView(image: UIImage(imageLiteralResourceName: "empty"))
        
        imageView.backgroundColor = .clear
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 15)
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        emptyView.addSubview(imageView)
        
        
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        imageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        titleLabel.text = title
        messageLabel.text = message
        
        titleLabel.textAlignment = .center
        messageLabel.textAlignment = .center
        
        titleLabel.numberOfLines = 0
        messageLabel.numberOfLines = 0
        
        UIView.animate(withDuration: 1, animations: {
            
            imageView.transform = CGAffineTransform(rotationAngle: .pi / 15)
        }, completion: { (finish) in
            UIView.animate(withDuration: 1, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: -1 * (.pi / 15))
            }, completion: { (finish) in
                UIView.animate(withDuration: 1, animations: {
                    imageView.transform = CGAffineTransform.identity
                })
            })
            
        })
        self.backgroundView = emptyView
        self.separatorStyle = .none
        
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}


// MARK: - Create
extension UITableView {
    static func create(style: UITableView.Style = .plain,
                       estimatedRowHeight: CGFloat,
                       backgroundColor: UIColor = .clear,
                       headerView: UIView = UIView(),
                       footerView: UIView = UIView(),
                       keyboardDismissMode: UIScrollView.KeyboardDismissMode = .interactive) -> UITableView {
        let tableView = UITableView(frame: .zero, style: style)
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = estimatedRowHeight
        tableView.backgroundColor = backgroundColor
        tableView.keyboardDismissMode = .interactive
        return tableView
    }
}

// MARK: - Deque
extension UITableView {
    func deque<T: ViewIdentifier>(at indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.viewIdentifier, for: indexPath) as? T else {
            fatalError("can not deque cell with identifier \(T.viewIdentifier) from tableView \(self)")
        }
        return cell
    }
}
