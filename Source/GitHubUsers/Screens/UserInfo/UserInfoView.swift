//
//  UserInfoView.swift
//  GitHubUsers
//
//  Created by JC on 3/3/23.
//

import UIKit

class UserInfoView: UIView {
    
    // MARK: - Private Properties
    
    private weak var delegate: UserInfoDelegate?
    
    private let scrollView = UIScrollView()
    
    private var headerView: UIView!
    private var firstRowCardView: UIView!     // Repositories and gists
    private var secondRowCardView: UIView!    // Followers and following
    private var buttonCardView: UIView!
    private let dateLb = GFBodyLabel(textAlignment: .center)
    
    private let padding: CGFloat = 20
    private let rowCardViewHeight: CGFloat = 72
    
    // MARK: - Initializers
    
    init(userInfo: UserInfo, delegate: UserInfoDelegate) {
        super.init(frame: .zero)
        
        // background color will change depending on the device's theme (light/dark)
        backgroundColor = .systemBackground
        
        self.delegate = delegate
        
        configureScrollView()
        configureHeaderView(userInfo: userInfo)
        configureFirstRowCardView(
            publicRepos: String(userInfo.publicRepos),
            publicGists: String(userInfo.publicGists)
        )
        configureSecondRowCardView(userInfo: userInfo)
        configureButtonCardView(htmlUrl: userInfo.htmlUrl)
        configureDateLbView(createdAt: userInfo.createdAt.toString(with: .medium))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func configureScrollView() {
        addSubview(scrollView)
        scrollView.pinToEdges(of: self)
    }
    
    private func configureHeaderView(userInfo: UserInfo) {
        headerView = GFUserInfoHeaderView(userInfo: userInfo)
        
        scrollView.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        let maxHeaderHeight: CGFloat = 230
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding),
            headerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            headerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            headerView.heightAnchor.constraint(lessThanOrEqualToConstant: maxHeaderHeight),
        ])
    }
    
    private func configureFirstRowCardView(publicRepos: String, publicGists: String) {
        firstRowCardView = GFItemInfoCardView(
            itemLeft: GFBaseItem(itemInfoType: .repos, with: publicRepos),
            itemRight: GFBaseItem(itemInfoType: .gists, with: publicGists)
        )
        
        scrollView.addSubview(firstRowCardView)
        firstRowCardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstRowCardView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding),
            firstRowCardView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            firstRowCardView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            firstRowCardView.heightAnchor.constraint(equalToConstant: rowCardViewHeight),
        ])
    }
    
    private func configureSecondRowCardView(userInfo: UserInfo) {
        secondRowCardView = GFItemInfoCardView(
            itemLeft: GFFollowersItem(
                itemInfoType: .followers,
                with: String(userInfo.followers),
                userInfo: userInfo,
                delegate: self
            ),
            itemRight: GFFollowingItem(
                itemInfoType: .following,
                with: String(userInfo.following),
                userInfo: userInfo,
                delegate: self
            )
        )
        
        scrollView.addSubview(secondRowCardView)
        secondRowCardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secondRowCardView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding),
            secondRowCardView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            secondRowCardView.topAnchor.constraint(equalTo: firstRowCardView.bottomAnchor, constant: padding),
            secondRowCardView.heightAnchor.constraint(equalToConstant: rowCardViewHeight),
        ])
    }
    
    private func configureButtonCardView(htmlUrl: URL) {
        buttonCardView = GFGitHubProfileCardView(
            actionBt: GFButton(
                color: .systemPurple,
                title: "UserInfo.github_profile".localized(),
                image: SFSymbol.user.image
            ),
            url: htmlUrl,
            delegate: self
        )
        
        scrollView.addSubview(buttonCardView)
        buttonCardView.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonCardHeight: CGFloat = 80
        
        NSLayoutConstraint.activate([
            buttonCardView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding),
            buttonCardView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            buttonCardView.topAnchor.constraint(equalTo: secondRowCardView.bottomAnchor, constant: padding),
            buttonCardView.heightAnchor.constraint(equalToConstant: buttonCardHeight),
        ])
    }
    
    private func configureDateLbView(createdAt: String) {
        scrollView.addSubview(dateLb)
        dateLb.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLb.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding),
            dateLb.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            dateLb.topAnchor.constraint(equalTo: buttonCardView.bottomAnchor, constant: padding),
            dateLb.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
        
        dateLb.text = "\("UserInfo.github_user_since".localized()) \(createdAt)"
    }
    
}

// MARK: - Delegates

extension UserInfoView: GFGitHubProfileCardViewDelegate {
    
    func didTapGitHubProfile(for url: URL) {
        delegate?.didTapGitHubProfile(for: url)
    }
    
}

extension UserInfoView: GFFollowersItemViewDelegate {
    
    func didTapFollowers(for userInfo: UserInfo) {
        delegate?.didTapFollowers(for: userInfo)
    }
    
}

extension UserInfoView: GFFollowingItemViewDelegate {
    
    func didTapFollowing(for userInfo: UserInfo) {
        delegate?.didTapFollowing(for: userInfo)
    }
    
}
