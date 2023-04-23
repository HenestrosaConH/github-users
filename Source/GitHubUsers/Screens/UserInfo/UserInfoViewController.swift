//
//  UserInfoViewController.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 2/7/22.
//

import UIKit

class UserInfoViewController: UIViewController, HasCustomView {

    // MARK: Protocol Typealias
    
    typealias CustomView = SearchView
    
    // MARK: - Private Properties
    
    private let userInfo: UserInfo
    private weak var delegate: UserListDelegate!
    private let favoriteRepository: FavoriteRepository
    
    private var isFavorited = false
    
    // MARK: - Initializers
    
    init(
        userInfo: UserInfo,
        delegate: UserListDelegate,
        favoriteRepository: FavoriteRepository
    ) {
        self.userInfo = userInfo
        self.favoriteRepository = favoriteRepository
        
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = UserInfoView(userInfo: userInfo, delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarButtons()
    }
    
    // MARK: - Private Methods
    
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
        
        isFavorited = favoriteRepository.get(objectWith: userInfo.username) != nil
        
        if isFavorited {
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
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
    
    @objc private func didTapFavorites() {
        if isFavorited {
            let success = favoriteRepository.delete(objectWith: userInfo.username)
            
            if success {
                navigationItem.leftBarButtonItem?.image = SFSymbol.addFavorite.image
            }
        } else {
            navigationItem.leftBarButtonItem?.image = SFSymbol.removeFavorite.image
            favoriteRepository.save(object: userInfo.toUser())
        }
    
        isFavorited = !isFavorited
    }

}

// MARK: - Delegates

extension UserInfoViewController: UserInfoDelegate {
    
    func didTapGitHubProfile(for url: URL) {
        presentSafariVC(with: url)
    }
    
    func didTapFollowers(for userInfo: UserInfo) {
        guard userInfo.followers != 0 else {
            presentGFAlert(title: "title_no_followers".localized(), message: "description_no_followers".localized())
            return
        }
        
        delegate.didRequestFollowers(for: userInfo.username)
        dismissVC()
    }
    
    func didTapFollowing(for userInfo: UserInfo) {
        guard userInfo.following != 0 else {
            presentGFAlert(title: "title_no_followings".localized(), message: "description_no_followings".localized())
            return
        }
        
        delegate.didRequestFollowings(for: userInfo.username)
        dismissVC()
    }
    
}
