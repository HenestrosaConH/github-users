//
//  FavoriteListViewController.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 21/6/22.
//

import UIKit

class FavoriteListViewController: UIViewController, HasCustomView {

    // MARK: Protocol Typealias
    
    typealias CustomView = FavoriteListView
    
    // MARK: - Properties
    
    private var favoriteListView: FavoriteListView!
        
    // MARK: - Initializers
    
    init(favoriteRepository: FavoriteRepository) {        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        favoriteListView = FavoriteListView(
            delegate: self,
            dataSource: FavoriteListDataSource(
                favoriteRepository: FavoriteRepository(),
                delegate: self
            )
        )
        view = favoriteListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func configureViewController() {
        title = "favorites".localized()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

// MARK: - Delegates

extension FavoriteListViewController: FavoriteListDelegate {
    
    func didSelectRow(at index: Int) {
        let favorite = customView.dataSource.favorite(at: index)
        let destinationVC = UserListViewController(
            username: favorite.username,
            favoriteRepository: FavoriteRepository(),
            usersService: UsersService(),
            imageService: ImageService()
        )
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func showError(title: String, message: String) {
        presentGFAlert(title: title, message: message)
    }
    
}
