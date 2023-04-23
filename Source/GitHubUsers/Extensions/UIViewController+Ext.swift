//
//  UIVIewController+Ext.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 27/6/22.
//

import UIKit
import SafariServices

fileprivate var loadingView: UIView!

extension UIViewController {
    
    /// Displays the GFAlertViewController from any UIViewController class
    func presentGFAlert(title: String, message: String, buttonTitle: String = "OK") {
        let alertVC = GFAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve // presentation animation
        self.present(alertVC, animated: true)
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        self.present(safariVC, animated: true)
    }
    
    /// Shows a loading view while retrieving data from the network
    func showLoadingView() {
        loadingView = UIView(frame: view.bounds)
        view.addSubview(loadingView)
        
        loadingView.backgroundColor = .systemBackground
        loadingView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            loadingView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        loadingView.addSubview(activityIndicator)
        
        activityIndicator.color = .systemGreen
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25, animations: {
                loadingView.alpha = 0.0
            }, completion: { _ in
                loadingView?.removeFromSuperview()
                loadingView = nil
            })
        }
    }
    
}
