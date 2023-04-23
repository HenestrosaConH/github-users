//
//  FavoriteListDataSource.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 2/3/23.
//

import UIKit

class FavoriteListDataSource: NSObject, UITableViewDataSource {

    // MARK: Properties
    
    private let favoriteRepository: FavoriteRepository
    private weak var delegate: FavoriteListDelegate?
    
    private var favorites: [User]
    
    func favorite(at row: Int) -> User {
        return favorites[row]
    }
    
    // MARK: - Initializers
    
    init(favoriteRepository: FavoriteRepository, delegate: FavoriteListDelegate?) {
        self.favoriteRepository = favoriteRepository
        self.delegate = delegate
        
        self.favorites = favoriteRepository.getAll()
    }
    
    // MARK: - Methods
    
    func reloadData(_ tableView: UITableView) {
        self.favorites = favoriteRepository.getAll()
        tableView.reloadData()
    }
    
    // MARK: Protocol Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favorites.isEmpty {
            tableView.backgroundView = GFEmptyStateView(
                message: "FavoriteList.empty_state".localized()
            )
        } else {
            tableView.backgroundView = nil
        }
        
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GFFavoriteCell.reuseId) as! GFFavoriteCell
        var favorite = favorites[indexPath.row]
        favorite.avatarImage = try? ImageManager.get(for: favorite.username)
        cell.set(favorite: favorite)
        
        return cell
    }
        
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            let favoriteToDelete = favorites[indexPath.row]
            let success = favoriteRepository.delete(objectWith: favoriteToDelete.username)
            
            if success {
                favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }

    }
    
}
