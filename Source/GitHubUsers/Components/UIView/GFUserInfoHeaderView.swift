//
//  GFUserInfoHeaderView.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 3/7/22.
//

import UIKit

class GFUserInfoHeaderView: UIView {

    // MARK: - Private Properties
    
    private lazy var avatarIv = GFAvatarImageView()
    private lazy var usernameLb = GFTitleLabel(textAlignment: .left, fontSize: 34)
    private lazy var nameLb = GFSecondaryTitleLabel(fontSize: 18)
    private lazy var locationIv = UIImageView()
    private lazy var locationLb = GFSecondaryTitleLabel(fontSize: 18)
    private lazy var bioLb = GFBodyLabel(textAlignment: .left)
    
    private let padding: CGFloat = 20
    private let textImagePadding: CGFloat = 12
    
    // MARK: - Initializers
    
    init(userInfo: UserInfo) {
        super.init(frame: .zero)
        
        configureAvatarIv(avatarImage: userInfo.avatarImage)
        configureUsernameLb(username: userInfo.username)
        configureNameLb(name: userInfo.name)
        configureLocationIv()
        configureLocationLb(location: userInfo.location)
        configureBioLb(bio: userInfo.bio)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configureAvatarIv(avatarImage: UIImage?) {
        addSubview(avatarIv)
        
        avatarIv.image = avatarImage ?? GFImages.avatarPlaceholder.image
        
        let size: CGFloat = 90
        
        NSLayoutConstraint.activate([
            avatarIv.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarIv.leadingAnchor.constraint(equalTo: leadingAnchor),
            avatarIv.widthAnchor.constraint(equalToConstant: size),
            avatarIv.heightAnchor.constraint(equalToConstant: size),
        ])
    }
    
    private func configureUsernameLb(username: String) {
        addSubview(usernameLb)
        
        usernameLb.text = username
        
        let height: CGFloat = 38
        
        NSLayoutConstraint.activate([
            usernameLb.topAnchor.constraint(equalTo: avatarIv.topAnchor),
            usernameLb.leadingAnchor.constraint(equalTo: avatarIv.trailingAnchor, constant: textImagePadding),
            usernameLb.trailingAnchor.constraint(equalTo: trailingAnchor),
            usernameLb.heightAnchor.constraint(equalToConstant: height),
        ])
    }
    
    private func configureNameLb(name: String?) {
        addSubview(nameLb)
        
        nameLb.text = name
        
        let height: CGFloat = 20
        
        NSLayoutConstraint.activate([
            nameLb.centerYAnchor.constraint(equalTo: avatarIv.centerYAnchor, constant: 8),
            nameLb.leadingAnchor.constraint(equalTo: avatarIv.trailingAnchor, constant: textImagePadding),
            nameLb.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLb.heightAnchor.constraint(equalToConstant: height),
        ])
    }
    
    private func configureLocationIv() {
        addSubview(locationIv)
        
        locationIv.image = SFSymbol.location.image
        locationIv.tintColor = .secondaryLabel
        locationIv.translatesAutoresizingMaskIntoConstraints = false
        
        let size: CGFloat = 20
        
        NSLayoutConstraint.activate([
            locationIv.bottomAnchor.constraint(equalTo: avatarIv.bottomAnchor),
            locationIv.leadingAnchor.constraint(equalTo: avatarIv.trailingAnchor, constant: textImagePadding),
            locationIv.widthAnchor.constraint(equalToConstant: size),
            locationIv.heightAnchor.constraint(equalToConstant: size),
        ])
    }
    
    private func configureLocationLb(location: String?) {
        addSubview(locationLb)
        
        locationLb.text = location ?? "-"
        
        let height: CGFloat = 20
        
        NSLayoutConstraint.activate([
            locationLb.centerYAnchor.constraint(equalTo: locationIv.centerYAnchor),
            locationLb.leadingAnchor.constraint(equalTo: locationIv.trailingAnchor, constant: 5),
            locationLb.trailingAnchor.constraint(equalTo: trailingAnchor),
            locationLb.heightAnchor.constraint(equalToConstant: height),
        ])
    }
    
    private func configureBioLb(bio: String?) {
        addSubview(bioLb)
        
        bioLb.text = bio ?? ""
        bioLb.numberOfLines = 0 // unlimited text
        
        NSLayoutConstraint.activate([
            bioLb.topAnchor.constraint(equalTo: avatarIv.bottomAnchor, constant: padding),
            bioLb.leadingAnchor.constraint(equalTo: avatarIv.leadingAnchor),
            bioLb.trailingAnchor.constraint(equalTo: trailingAnchor),
            bioLb.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

}
