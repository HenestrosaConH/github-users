//
//  SearchViewController.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 21/6/22.
//

import UIKit

class SearchViewController: UIViewController, HasCustomView {

    // MARK: Protocol Typealias
    
    typealias CustomView = SearchView
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = SearchView(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // We change the value of `setNavigationBarHidden` in `viewWillAppear` because
        // `viewDidLoad` gets called only once, so if we go back to this `ViewController`
        // from another `ViewController`, the navigation bar will be visible.
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

}

// MARK: - Delegates

extension SearchViewController: SearchDelegate {
    
    func searchUser(with username: String?) {
        guard let username = username, !username.isEmpty else {
            presentGFAlert(title: "SearchViewController.title_empty_username".localized(), message: "SearchViewController.description_empty_username".localized())
            return
        }
        
        // Dismisses the keyboard when exiting the view controller
        customView.resignUsernameTfFirstResponder()
        
        let followersListVC = UserListViewController(
            username: username,
            favoriteRepository: FavoriteRepository(),
            usersService: UsersService(),
            imageService: ImageService()
        )
        
        navigationController?.pushViewController(followersListVC, animated: true)
    }
    
}
