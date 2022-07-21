//
//  GFButton.swift
//  GitHubFollowers
//
//  Created by JC on 26/6/22.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    // Won't get executed because this initialiser will be called if an instance of the view is used in a storyboard scene. 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(color: UIColor, title: String, image: UIImage) {
        self.init(frame: .zero)
        set(color: color, title: title, image: image)
    }
    
    func set(color: UIColor, title: String, image: UIImage) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = .systemBackground
        configuration?.title = title
        
        configuration?.image = image
        configuration?.imagePadding = 6
        configuration?.imagePlacement = .leading
    }
    
    private func configure() {
        configuration = .filled()
        configuration?.cornerStyle = .medium
        
        // If set to true, the system automatically creates a set of constraints based on the view’s frame and its autoresizing mask.
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
