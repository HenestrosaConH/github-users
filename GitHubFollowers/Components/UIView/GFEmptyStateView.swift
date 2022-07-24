//
//  GFEmptyState.swift
//  GitHubFollowers
//
//  Created by JC on 30/6/22.
//

import UIKit

class GFEmptyStateView: UIView {

    private let messageLb = GFTitleLabel(textAlignment: .center, fontSize: 28)
    private let logoIv = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViewController()
        configureMessageLb()
        configureLogoIv()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLb.text = message
    }
    
    private func configureViewController() {
        backgroundColor = .systemBackground
    }
    
    private func configureMessageLb() {
        addSubview(messageLb)
        
        let padding: CGFloat = 40
        
        messageLb.numberOfLines = 3
        messageLb.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            messageLb.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLb.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            messageLb.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            messageLb.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    private func configureLogoIv() {
        addSubview(logoIv)
        
        // 1.3 makes the ImageView 30% percent larger than the width of the screen
        let multiplier: CGFloat = 1.3
        
        logoIv.image = Images.emptyStateLogo.image
        logoIv.translatesAutoresizingMaskIntoConstraints = false
        
        // the trailing constant is positive because we are pushing the image beyond the right edge of the screen
        NSLayoutConstraint.activate([
            logoIv.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: multiplier),
            logoIv.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: multiplier),
            logoIv.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoIv.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40),
        ])
    }
    
}
