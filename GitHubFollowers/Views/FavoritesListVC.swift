//
//  FavoritesListVC.swift
//  GitHubFollowers
//
//  Created by JC on 21/6/22.
//

import UIKit

class FavoritesListVC: UIViewController {

    private let tableView = UITableView()
    private var favorites: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        getFavorites()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(GFFavoriteCell.self, forCellReuseIdentifier: GFFavoriteCell.reuseId)
    }
    
    private func getFavorites() {
        PersistenceManager.shared.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                DispatchQueue.main.async {
                    self.updateUI(with: favorites)
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentGFAlert(title: "Something went wrong", message: error.rawValue)
                }
            }
        }
    }
    
    private func updateUI(with favorites: [Follower]) {
        if favorites.isEmpty {
            self.showEmptyStateView(with: "No favorites?\nAdd one on the follower screen.", in: self.view)
        } else {
            self.favorites = favorites
            self.tableView.reloadData()
            // We show the empty state by default so, once we get the tableView data, we need to bring the tableView to the top of the view hierarchy.
            self.view.bringSubviewToFront(self.tableView)
        }
    }
    
}

extension FavoritesListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GFFavoriteCell.reuseId) as! GFFavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destinationVC = FollowersListVC(username: favorite.username)
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        
        PersistenceManager.shared.update(with: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard error == nil else {
                DispatchQueue.main.async {
                    self.presentGFAlert(title: "Unable to remove", message: error!.rawValue)
                }
                return
            }
            
            DispatchQueue.main.async {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
            }
        }
    }
    
    // Hides the empty cells from the TableView
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView(frame: .zero)
    }
    
}
