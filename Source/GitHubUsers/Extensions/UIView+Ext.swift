//
//  UIView+Ext.swift
//  GitHubUsers
//
//  Created by JC on 21/7/22.
//

import UIKit

extension UIView {
    
    // UIView... is a variadic parameter, which turns the parameters passed to the function into an array. For example, if we were to call addSubviews, we would do addSubviews(stackView, actionButton, bioLb)
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    func pinToEdges(of superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
    
}
