//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by JC on 29/6/22.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    private let placeholderImage = Images.avatarPlaceholder
    private let cache = NetworkManager.shared.imageCache
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(from urlString: String) {
        NetworkManager.shared.downloadImage(from: urlString) { [weak self] image in
            guard let self = self else { return }
            self.image = image
        }
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true // this makes the image appear round instead of square
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
