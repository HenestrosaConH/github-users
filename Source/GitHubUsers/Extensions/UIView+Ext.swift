//
//  UIView+Ext.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 21/7/22.
//

import UIKit

extension UIView {
    
    func pinToEdges(of superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
    
    func showEmptyStateView(with message: String) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = bounds
        addSubview(emptyStateView)
    }
    
    func hideEmptyStateView() {
        subviews.first(where: { $0 is GFEmptyStateView })?.removeFromSuperview()
    }
    
}
