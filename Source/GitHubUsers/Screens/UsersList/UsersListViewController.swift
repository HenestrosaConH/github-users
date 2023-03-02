//
//  FollowersListVC.swift
//  GitHubUsers
//
//  Created by JC on 27/6/22.
//

import UIKit

protocol UsersListViewControllerDelegate: AnyObject {
    func didRequestFollowers(for username: String)
    func didRequestFollowings(for username: String)
}

class UsersListViewController: UIViewController {

    // MARK: - Private Enums
    
    private enum Section {
        case main
    }
    
    private enum ScopeButtonsOption {
        case followers
        case following
        
        var title: String {
            switch self {
            case .followers: return "followers".localized()
            case .following: return "following".localized()
            }
        }
        
        var index: Int {
            switch self {
            case .followers: return 0
            case .following: return 1
            }
        }
    }
    
    
    // MARK: - Private Properties
    
    private var username: String!
    private var userInfo: UserInfo!
    
    private let usersService: UsersServiceable
    private let imageService: ImageServiceable
    
    private var isFavorited = false
    private var selectedScope = 0
    
    private var users: [User] = []
    private let perPage: Int = 100
    private var page: Int = 1
    private var hasMoreUsers = true // avoids unnecessary network calls in case that the user doesn't have more followers than the currently visible ones.
    private var isLoadingMoreUsers = false

    private let searchController = UISearchController()
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, User>!
    
    
    // MARK: - Initializers
    
    init(
        username: String,
        usersService: UsersServiceable = UsersService(),
        imageService: ImageServiceable = ImageService()
    ) {
        self.usersService = usersService
        self.imageService = imageService
        
        super.init(nibName: nil, bundle: nil)
        
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureNavigationBarButtons()
        configureSearchController()
        configureCollectionView()
        
        getFollowers()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    // MARK: - Private Methods
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureNavigationBarButtons() {
        // Favorite button
        var favoriteIcon: UIImage!
        
        isFavorited = isUserFavorited()
        
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
        
        // User info button
        let userInfoItem = UIBarButtonItem(
            image: SFSymbol.user.image,
            style: .plain,
            target: self,
            action: #selector(didTapUserInfo)
        )
        
        navigationItem.rightBarButtonItems = [favoriteItem, userInfoItem]
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
        searchController.searchBar.placeholder = "UsersListViewController.search_placeholder".localized()
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.scopeButtonTitles = [
            ScopeButtonsOption.followers.title,
            ScopeButtonsOption.following.title
        ]
        searchController.searchBar.delegate = self
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    private func getFollowers() {
        showLoadingView()
        isLoadingMoreUsers = true
        
        Task(priority: .background) {
            let result = await usersService.getFollowers(for: username, perPage: perPage, page: page)
            
            switch result {
            case .success(let followers):
                updateUI(with: followers)
            case .failure(let error):
                print(error.localizedDescription)
                presentGFAlert(title: error.title, message: error.description)
            }
            
            isLoadingMoreUsers = false
            dismissLoadingView()
        }
    }
    
    private func getFollowings() {
        showLoadingView()
        isLoadingMoreUsers = true
        
        Task(priority: .background) {
            let result = await usersService.getFollowings(for: username, perPage: perPage, page: page)
            
            switch result {
            case .success(let followings):
                updateUI(with: followings)
            case .failure(let error):
                print(error.localizedDescription)
                presentGFAlert(title: error.title, message: error.description)
            }
            
            isLoadingMoreUsers = false
            dismissLoadingView()
        }
    }
    
    private func getUserInfo(for username: String) async -> UserInfo? {
        showLoadingView()
        
        let result = await usersService.getUserInfo(for: username)
        
        switch result {
        case .success(var userInfo):
            let imageResult = await imageService.getAvatar(from: userInfo.avatarUrl)
            
            dismissLoadingView()
            
            switch imageResult {
            case .success(let image):
                userInfo.avatarImage = image
                return userInfo
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        case .failure(let error):
            presentGFAlert(title: error.title, message: error.description)
        }
        
        return nil
    }
    
    private func isUserFavorited() -> Bool {
        let result = UserDefaultsManager.shared.isUserInFavorites(username: username)
        
        switch result {
        case .success(let isFavorited):
            return isFavorited
            
        case .failure(let error):
            print(error.localizedDescription)
            presentGFAlert(title: error.title, message: error.description)
            return false
        }
    }
    
    private func removeUserFromFavorites(user: User) {
        UserDefaultsManager.shared.update(with: user, actionType: .remove) { [weak self] error in
            guard let self = self else { return }

            if let error = error {
                self.presentGFAlert(title: error.title, message: error.description)
            } else {
                self.navigationItem.rightBarButtonItem?.image = SFSymbol.addFavorite.image
            }
        }
    }
    
    private func addUserToFavorites(user: User) {
        UserDefaultsManager.shared.update(with: user, actionType: .add) { [weak self] error in
            guard let self = self else { return }

            if let error = error {
                self.presentGFAlert(title: error.title, message: error.description)
            } else {
                self.navigationItem.rightBarButtonItem?.image = SFSymbol.removeFavorite.image
            }
        }
    }
    
    private func resetData(for username: String) {
        // Resetting variables
        title = username
        self.username = username
        page = 1
        userInfo = nil
        searchController.searchBar.selectedScopeButtonIndex = selectedScope
        
        users.removeAll()
        
        // Getting new list of users
        switch selectedScope {
        case ScopeButtonsOption.followers.index:
            getFollowers()
        case ScopeButtonsOption.following.index:
            getFollowings()
        default:
            print("Something's wrong with selectedScope in resetData")
        }
        
        configureNavigationBarButtons()
    }
    
    private func updateUI(with followers: [User]) {
        self.hasMoreUsers = followers.count == perPage
        self.users.append(contentsOf: followers)
        
        if self.users.isEmpty {
            var message = ""
            // Getting new list of users
            switch selectedScope {
            case ScopeButtonsOption.followers.index:
                message = "UsersListViewController.empty_state_follwers".localized()
            case ScopeButtonsOption.following.index:
                message = "UsersListViewController.empty_state_following".localized()
            default:
                print("Something went wrong with the selectedScope")
            }

            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                //self.navigationItem.searchController = nil
                self.showEmptyStateView(with: message, in: self.view)
            }
            return
        } else {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                //self.navigationItem.searchController = nil
                self.hideEmptyStateView(from: self.view)
            }
        }
        
        self.updateData(on: self.users)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, User>(collectionView: collectionView, cellProvider: { [weak self] collectionView, indexPath, user in
            guard let self = self else {
                return nil
            }
            
            var followerCell = user
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GFFollowerCell.reuseId, for: indexPath) as! GFFollowerCell
            cell.avatarIv.image = GFImages.avatarPlaceholder.image
            
            Task(priority: .background) {
                let result = await self.imageService.getAvatar(from: user.avatarUrl)
                
                switch result {
                case .success(let image):
                    followerCell.avatarImage = image
                case .failure(let error):
                    print(error.localizedDescription)
                    followerCell.avatarImage = GFImages.avatarPlaceholder.image
                }
                
                cell.set(user: followerCell)
            }
            
            return cell
        })
    }

    private func updateData(on followers: [User]) {
        // We have to pass a Section and a User. They then go to the hash function to be get a unique value and to be compared with the previous snapshot. Useful for dynamic table/collection views.
        var snapshot = NSDiffableDataSourceSnapshot<Section, User>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    
    // MARK: Actions
    
    @objc private func didTapFavorites() {
        showLoadingView()
        
        Task(priority: .background) {
            let result = await usersService.getUserInfo(for: username)
            
            dismissLoadingView()
            
            switch result {
            case .success(var userInfo):
                if isFavorited {
                    removeUserFromFavorites(user: userInfo.toUser())
                } else {
                    let imageResult = await imageService.getAvatar(from: userInfo.avatarUrl)
                    
                    switch imageResult {
                    case .success(let image):
                        userInfo.avatarImage = image
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    
                    addUserToFavorites(user: userInfo.toUser())
                }
                isFavorited = !isFavorited
            
            case .failure(let error):
                presentGFAlert(title: error.title, message: error.description)
            }
        }
    }

    @objc private func didTapUserInfo() {
        // Refactor
        if userInfo == nil {
            Task {
                userInfo = await getUserInfo(for: username)
                guard userInfo != nil else {
                    presentGFAlert(title: GFNetworkError.uncompletedRequest.title, message: GFNetworkError.uncompletedRequest.description)
                    return
                }
                
                let destinationVC = UserInfoViewController(userInfo: userInfo, delegate: self)
                let navController = UINavigationController(rootViewController: destinationVC)
                present(navController, animated: true)
            }
        } else {
            let destinationVC = UserInfoViewController(userInfo: userInfo, delegate: self)
            let navController = UINavigationController(rootViewController: destinationVC)
            present(navController, animated: true)
        }
    }
    
}


// MARK: Delegates

extension UsersListViewController: UICollectionViewDelegate {
    
    /**
     Checks when the user reaches the bottom of the screen and calls the getFollowers() method if there are more followers left to show.
     */
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard hasMoreUsers, !isLoadingMoreUsers else {
            return
        }
        
        if indexPath.item == users.count - 1 {
            page += 1
            
            switch selectedScope {
            case ScopeButtonsOption.followers.index:
                getFollowers()
            case ScopeButtonsOption.following.index:
                getFollowings()
            default:
                print("Something's wrong with selectedScope in UsersListViewController")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let user = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        Task {
            let userInfo = await getUserInfo(for: user.username)
            
            guard let userInfo = userInfo else {
                presentGFAlert(
                    title: GFNetworkError.noResponse.title,
                    message: GFNetworkError.noResponse.description
                )
                return
            }
            
            let destinationVC = UserInfoViewController(userInfo: userInfo, delegate: self)
            let navController = UINavigationController(rootViewController: destinationVC)
            present(navController, animated: true)
        }
    }
    
}

extension UsersListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.selectedScope = selectedScope
        resetData(for: username)
    }

}

extension UsersListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            updateData(on: users)
            return
        }
        
        let filteredFollowers = users.filter({ user in
            user.username.lowercased().contains(filter.lowercased())
        })
        
        /* Same as above:
         let filteredFollowers = followers.filter { $0.username.lowercased().contains(filter.lowercased()) }
         */
        
        updateData(on: filteredFollowers)
    }
    
}

extension UsersListViewController: UsersListViewControllerDelegate {
    
    func didRequestFollowers(for username: String) {
        selectedScope = ScopeButtonsOption.followers.index
        resetData(for: username)
    }
    
    func didRequestFollowings(for username: String) {
        selectedScope = ScopeButtonsOption.following.index
        resetData(for: username)
    }
    
}
