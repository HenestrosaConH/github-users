//
//  GFTabBarController.swift
//  GitHubUsers
//
//  Created by JC on 11/7/22.
//

import UIKit

class GFTabBarController: UITabBarController {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    
    // MARK: - Private Methods
    
    /**
     * Sets up the bottom tab bar controller with two navigation controllers
     * holding a view controller each.
     */
    private func configureTabBar() {
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC(), createFavoritesListNC()]
        
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    private func createSearchNC() -> UINavigationController {
        let searchVC = SearchViewController()
        searchVC.title = "search".localized()
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    private func createFavoritesListNC() -> UINavigationController {
        let favoritesListVC = FavoritesListViewController()
        favoritesListVC.title = "favorites".localized()
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesListVC)
    }
    
}
