//
//  GFFollowerCell.swift
//  GitHubFollowers
//
//  Created by JC on 29/6/22.
//

import UIKit

class GFFollowerCell: UICollectionViewCell {
    
    static let reuseId = "FollowerCell"
    
    private let avatarIv = GFAvatarImageView(frame: .zero)
    private let usernameLb = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    private let padding: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAvatarIv()
        configureUsernameLb()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        usernameLb.text = follower.username
        avatarIv.setImage(from: follower.avatarUrl)
    }
    
    private func configureAvatarIv() {
        addSubview(avatarIv)
        
        NSLayoutConstraint.activate([
            avatarIv.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarIv.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarIv.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarIv.heightAnchor.constraint(equalTo: avatarIv.widthAnchor),
        ])
    }
    
    private func configureUsernameLb() {
        addSubview(usernameLb)
        
        NSLayoutConstraint.activate([
            usernameLb.topAnchor.constraint(equalTo: avatarIv.bottomAnchor, constant: 12),
            usernameLb.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            usernameLb.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLb.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
}
