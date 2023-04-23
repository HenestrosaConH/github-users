//
//  GFFavoriteCell.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 5/7/22.
//

import UIKit

class GFFavoriteCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    static let reuseId = "FollowerCell"
    
    // MARK: Private Properties
    
    private let avatarIv = GFAvatarImageView()
    private let usernameLb = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    private let padding: CGFloat = 12
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        
        configureAvatarIv()
        configureUsernameLb()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func set(favorite: User) {
        avatarIv.image = favorite.avatarImage
        usernameLb.text = favorite.username
    }
    
    // MARK: Private Methods
    
    private func configureAvatarIv() {
        addSubview(avatarIv)
        
        let size: CGFloat = 60
        
        NSLayoutConstraint.activate([
            avatarIv.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarIv.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarIv.heightAnchor.constraint(equalToConstant: size),
            avatarIv.widthAnchor.constraint(equalToConstant: size),
        ])
    }
    
    private func configureUsernameLb() {
        addSubview(usernameLb)
        
        NSLayoutConstraint.activate([
            usernameLb.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLb.leadingAnchor.constraint(equalTo: avatarIv.trailingAnchor, constant: padding * 2),
            usernameLb.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: padding),
            usernameLb.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
