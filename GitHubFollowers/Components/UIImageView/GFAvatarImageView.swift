//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by JC on 29/6/22.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    private let imageService: ImageServiceable
    private let placeholderImage = Images.avatarPlaceholder
    
    init(imageService: ImageServiceable = ImageService()) {
        self.imageService = imageService
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(from urlString: String) {
        Task(priority: .background) {
            let result = await imageService.getAvatar(from: urlString)
        
            switch result {
            case .success(let image):
                self.image = image
            case .failure(let error):
                image = placeholderImage.image
                print(error)
            }
        }
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true // this makes the image appear round instead of square
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
