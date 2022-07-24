//
//  FollowersListVC.swift
//  GitHubFollowers
//
//  Created by JC on 27/6/22.
//

import UIKit

protocol FollowersListVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class FollowersListVC: UIViewController {

    private enum Section {
        case main
    }
    
    private var username: String!
    private let usersService: UsersServiceable
    
    private let searchController = UISearchController()
    
    private var followers: [Follower] = []
    private let perPage: Int = 100
    private var page: Int = 1
    private var hasMoreFollowers = true // avoids unnecessary network calls in case that the user doesn't have more followers than the currently visible ones.
    private var isLoadingMoreFollowers = false

    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    init(username: String, usersService: UsersServiceable = UsersService()) {
        self.usersService = usersService
        super.init(nibName: nil, bundle: nil)
        
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addToFavorites = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavoritesTapped))
        navigationItem.rightBarButtonItem = addToFavorites
    }
    
    private func configureCollectionView() {
        let columnFlowLayout = UICollectionViewFlowLayout.createColumnFlowLayout(of: 3, in: view)
        
        // view.bounds fills up the whole screen with the collectionView
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: columnFlowLayout)
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.register(GFFollowerCell.self, forCellWithReuseIdentifier: GFFollowerCell.reuseId)
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    private func getFollowers() {
        showLoadingView()
        isLoadingMoreFollowers = true
        
        Task {
            let result = await usersService.getFollowers(for: username, perPage: perPage, page: page)
            
            switch result {
            case .success(let followers):
                updateUI(with: followers)
            case .failure(let error):
                presentGFAlert(title: "Error", message: error.rawValue)
            }
            
            isLoadingMoreFollowers = false
            dismissLoadingView()
        }
    }
    
    private func updateUI(with followers: [Follower]) {
        self.hasMoreFollowers = followers.count == perPage
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty {
            let message = "This user doesn't have any followers. Go follow them!"
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.navigationItem.searchController = nil
                self.showEmptyStateView(with: message, in: self.view)
            }
            return
        }
        
        self.updateData(on: self.followers)
        
        // Allows us to add the
        /*
        DispatchQueue.main.async {
            self.updateSearchResults(for: self.searchController)
        }
        */
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GFFollowerCell.reuseId, for: indexPath) as! GFFollowerCell
            cell.avatarIv.image = Images.avatarPlaceholder.image
            cell.set(follower: follower)
            
            return cell
        })
    }

    private func updateData(on followers: [Follower]) {
        // We have to pass a Section and a Follower . They then go to the hash function to be get a unique value and to be compared with the previous snapshot. Useful for dynamic table/collection views.
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    @objc private func addToFavoritesTapped() {
        showLoadingView()
        
        Task(priority: .background) {
            let result = await usersService.getUser(for: username)
            
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                addUserToFavorites(user: user)
            
            case .failure(let error):
                presentGFAlert(title: "Something went wrong", message: error.rawValue)
            }
        }
    }
    
    private func addUserToFavorites(user: User) {
        let favorite = Follower(username: user.username, avatarUrl: user.avatarUrl)
        PersistenceManager.shared.update(with: favorite, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
                DispatchQueue.main.async {
                    self.presentGFAlert(title: "Success", message: "You hace successfully favorited this user.")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.presentGFAlert(title: "Something went wrong", message: error.rawValue)
            }
        }
    }
    
}

extension FollowersListVC: UICollectionViewDelegate {
    
    /**
     Checks when the user reaches the bottom of the screen and calls the getFollowers() method if there are more followers left to show.
     */
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
        
        if indexPath.item == followers.count - 1 {
            guard hasMoreFollowers else {
                return
            }
            
            page += 1
            getFollowers()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let follower = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        let destinationVC = UserInfoVC(username: follower.username, delegate: self)
        let navController = UINavigationController(rootViewController: destinationVC)
        present(navController, animated: true)
    }
    
}

extension FollowersListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            updateData(on: followers)
            return
        }
        
        let filteredFollowers = followers.filter({ follower in
            follower.username.lowercased().contains(filter.lowercased())
        })
        
        /* Same as above:
         let filteredFollowers = followers.filter { $0.username.lowercased().contains(filter.lowercased()) }
         */
        
        updateData(on: filteredFollowers)
    }
    
}

extension FollowersListVC: FollowersListVCDelegate {
    
    func didRequestFollowers(for username: String) {
        // Resetting variables
        title = username
        self.username = username
        page = 1
        
        followers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        
        // Getting new list of users
        getFollowers()
    }
    
}
