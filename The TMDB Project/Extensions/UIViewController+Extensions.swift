//
//  UIViewController+Extensions.swift
//  The TMDB Project
//
//  Created by Beqa Tabunidze on 13.08.22.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /// Warnings
    func showAlertController(message: String = "Something went wrong!", title: String = "Error!"){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(ac, animated: true)
    }
    
    private static let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func startLoading() {

        DispatchQueue.main.async {
            let activityIndicator = UIViewController.activityIndicator
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = UIActivityIndicatorView.Style.large
            activityIndicator.color = .black
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(activityIndicator)
            NSLayoutConstraint.activate([
                activityIndicator.widthAnchor.constraint(equalToConstant: 80),
                activityIndicator.heightAnchor.constraint(equalToConstant: 80),
                activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
            self.view.isUserInteractionEnabled = false
            activityIndicator.startAnimating()
        }
    }
    
    func stopLoading() {
        let activityIndicator = UIViewController.activityIndicator
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}
