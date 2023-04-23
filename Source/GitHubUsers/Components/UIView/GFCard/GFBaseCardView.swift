//
//  GFBaseCardView.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 3/7/22.
//

import UIKit


/// Superclass of all GFCards
class GFBaseCardView: UIView {
    
    // MARK: Internal Properties
    
    internal let padding: CGFloat = 15
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        configureBackground()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configureBackground() {
        layer.cornerRadius = 18
        backgroundColor = .secondarySystemBackground
    }
    
}
