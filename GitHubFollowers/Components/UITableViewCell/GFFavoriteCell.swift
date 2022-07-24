//
//  GFFavoriteCell.swift
//  GitHubFollowers
//
//  Created by JC on 5/7/22.
//

import UIKit

class GFFavoriteCell: UITableViewCell {

    static let reuseId = "FollowerCell"
    
    private let avatarIv = GFAvatarImageView()
    private let usernameLb = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    private let padding: CGFloat = 12
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        
        configureAvatarIv()
        configureUsernameLb()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite: Follower) {
        avatarIv.setImage(from: favorite.avatarUrl)
        usernameLb.text = favorite.username
    }
    
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
