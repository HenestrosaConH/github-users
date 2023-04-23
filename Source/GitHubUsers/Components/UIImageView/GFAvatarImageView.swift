//
//  GFAvatarImageView.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 29/6/22.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true // this makes the image appear round instead of square
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
