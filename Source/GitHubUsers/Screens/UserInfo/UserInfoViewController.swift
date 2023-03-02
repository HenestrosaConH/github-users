//
//  UserInfoViewController.swift
//  GitHubUsers
//
//  Created by JC on 2/7/22.
//

import UIKit

class UserInfoViewController: UIViewController {

    // MARK: - Private Properties
    
    private let userInfo: UserInfo
    private weak var delegate: UsersListViewControllerDelegate!
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let headerView = UIView()
    private let firstRowCardView = UIView()     // Repositories and gists
    private let secondRowCardView = UIView()    // Followers and following
    private let buttonCardView = UIView()
    private let dateLb = GFBodyLabel(textAlignment: .center)
    private var itemViews: [UIView] = []
    
    
    // MARK: - Initializers
    
    init(userInfo: UserInfo, delegate: UsersListViewControllerDelegate) {
        self.userInfo = userInfo
        
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureNavigationBarButtons()
        configureScrollView()
        configureViews()
        loadDataInViews(with: userInfo)
    }
        
    
    // MARK: - Private Methods
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavigationBarButtons() {
        // Done button
        let doneBt = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(dismissVC)
        )
        navigationItem.rightBarButtonItem = doneBt
        
        // Favorite button
        
        var favoriteIcon: UIImage!
        
        //isFavorited = isUserFavorited()
        
        if true /*isFavorited*/ {
            favoriteIcon = SFSymbol.removeFavorite.image
        } else {
            favoriteIcon = SFSymbol.addFavorite.image
        }
        
        let favoriteItem = UIBarButtonItem(
            image: favoriteIcon,
            style: .plain,
            target: self,
            action: #selector(didTapFavorites)
        )
        
        navigationItem.leftBarButtonItem = favoriteItem
         
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
         
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
    
    private func configureViews() {
        itemViews = [
            headerView,
            firstRowCardView,
            secondRowCardView,
            buttonCardView,
            dateLb
        ]
        let padding: CGFloat = 20
        
        for itemView in itemViews {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            ])
        }
        
        let itemCardHeight: CGFloat = 72
        let buttonCardHeight: CGFloat = 80
        
        var headerHeight: CGFloat!
        if let _ = userInfo.bio {
            headerHeight = 210
        } else {
            headerHeight = 120
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: headerHeight),
            
            firstRowCardView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            firstRowCardView.heightAnchor.constraint(equalToConstant: itemCardHeight),
            
            secondRowCardView.topAnchor.constraint(equalTo: firstRowCardView.bottomAnchor, constant: padding),
            secondRowCardView.heightAnchor.constraint(equalToConstant: itemCardHeight),
            
            buttonCardView.topAnchor.constraint(equalTo: secondRowCardView.bottomAnchor, constant: padding),
            buttonCardView.heightAnchor.constraint(equalToConstant: buttonCardHeight),
            
            dateLb.topAnchor.constraint(equalTo: buttonCardView.bottomAnchor, constant: padding),
            dateLb.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    private func loadDataInViews(with userInfo: UserInfo) {
        self.add(
            childVC: GFUserInfoHeaderVC(userInfo: userInfo),
            to: self.headerView
        )
        self.add(
            childVC: GFItemInfoCardVC(
                itemLeft: GFBaseItem(itemInfoType: .repos, with: String(userInfo.publicRepos)),
                itemRight: GFBaseItem(itemInfoType: .gists, with: String(userInfo.publicGists))
            ),
            to: self.firstRowCardView
        )
        self.add(
            childVC: GFItemInfoCardVC(
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
            ),
            to: self.secondRowCardView
        )
        self.add(
            childVC: GFGitHubProfileButtonCardVC(
                actionBt: GFButton(color: .systemPurple, title: "UserInfoViewController.github_profile".localized(), image: SFSymbol.user.image),
                url: userInfo.htmlUrl,
                delegate: self
            ),
            to: self.buttonCardView
        )
        
        self.dateLb.text = "\("UserInfoViewController.github_user_since".localized()) \(userInfo.createdAt.toString(with: .medium))"
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    // MARK: Actions
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
    
    @objc private func didTapFavorites() {
        print("Favorites tapped")
    }

}


// MARK: - Delegates

extension UserInfoViewController: GFGitHubProfileButtonCardVCDelegate {
    
    func didTapGitHubProfile(for url: URL) {
        presentSafariVC(with: url)
    }
    
}

extension UserInfoViewController: GFFollowersItemVCDelegate {
    
    func didTapFollowers(for userInfo: UserInfo) {
        guard userInfo.followers != 0 else {
            presentGFAlert(title: "title_no_followers".localized(), message: "description_no_followers".localized())
            return
        }
        
        delegate.didRequestFollowers(for: userInfo.username)
        dismissVC()
    }

}

extension UserInfoViewController: GFFollowingItemVCDelegate {
    
    func didTapFollowing(for userInfo: UserInfo) {
        guard userInfo.following != 0 else {
            presentGFAlert(title: "title_no_followings".localized(), message: "description_no_followings".localized())
            return
        }
        
        delegate.didRequestFollowings(for: userInfo.username)
        dismissVC()
    }

}
