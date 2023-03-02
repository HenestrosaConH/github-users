//
//  GFUserInfoHeaderVC.swift
//  GitHubUsers
//
//  Created by JC on 3/7/22.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {

    // MARK: - Private Properties
    
    private let userInfo: UserInfo
    
    private let avatarIv = GFAvatarImageView()
    private let usernameLb = GFTitleLabel(textAlignment: .left, fontSize: 34)
    private let nameLb = GFSecondaryTitleLabel(fontSize: 18)
    private let locationIv = UIImageView()
    private let locationLb = GFSecondaryTitleLabel(fontSize: 18)
    private let bioLb = GFBodyLabel(textAlignment: .left)
    
    private let padding: CGFloat = 20
    private let textImagePadding: CGFloat = 12
    
    
    // MARK: - Initializers
    
    init(userInfo: UserInfo) {
        self.userInfo = userInfo
        
        super.init(nibName: nil, bundle: nil)
        
        configureAvatarIv()
        configureUsernameLb()
        configureNameLb()
        configureLocationIv()
        configureLocationLb()
        if let _ = userInfo.bio {
            configureBioLb()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Private Methods
    
    private func configureAvatarIv() {
        view.addSubview(avatarIv)
        
        avatarIv.image = userInfo.avatarImage ?? GFImages.avatarPlaceholder.image
        
        let size: CGFloat = 90
        
        NSLayoutConstraint.activate([
            avatarIv.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarIv.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarIv.widthAnchor.constraint(equalToConstant: size),
            avatarIv.heightAnchor.constraint(equalToConstant: size),
        ])
    }
    
    private func configureUsernameLb() {
        view.addSubview(usernameLb)
        
        usernameLb.text = userInfo.username
        
        let height: CGFloat = 38
        
        NSLayoutConstraint.activate([
            usernameLb.topAnchor.constraint(equalTo: avatarIv.topAnchor),
            usernameLb.leadingAnchor.constraint(equalTo: avatarIv.trailingAnchor, constant: textImagePadding),
            usernameLb.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLb.heightAnchor.constraint(equalToConstant: height),
        ])
    }
    
    private func configureNameLb() {
        view.addSubview(nameLb)
        
        nameLb.text = userInfo.name
        
        let height: CGFloat = 20
        
        NSLayoutConstraint.activate([
            nameLb.centerYAnchor.constraint(equalTo: avatarIv.centerYAnchor, constant: 8),
            nameLb.leadingAnchor.constraint(equalTo: avatarIv.trailingAnchor, constant: textImagePadding),
            nameLb.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLb.heightAnchor.constraint(equalToConstant: height),
        ])
    }
    
    private func configureLocationIv() {
        view.addSubview(locationIv)
        
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
    
    private func configureLocationLb() {
        view.addSubview(locationLb)
        
        locationLb.text = userInfo.location ?? "-"
        
        let height: CGFloat = 20
        
        NSLayoutConstraint.activate([
            locationLb.centerYAnchor.constraint(equalTo: locationIv.centerYAnchor),
            locationLb.leadingAnchor.constraint(equalTo: locationIv.trailingAnchor, constant: 5),
            locationLb.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLb.heightAnchor.constraint(equalToConstant: height),
        ])
    }
    
    private func configureBioLb() {
        view.addSubview(bioLb)
        
        bioLb.text = userInfo.bio ?? ""
        bioLb.numberOfLines = 0 // unlimited text
        
        NSLayoutConstraint.activate([
            bioLb.topAnchor.constraint(equalTo: avatarIv.bottomAnchor, constant: textImagePadding / 2),
            bioLb.leadingAnchor.constraint(equalTo: avatarIv.leadingAnchor),
            bioLb.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLb.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: textImagePadding / 2),
        ])
    }

}
