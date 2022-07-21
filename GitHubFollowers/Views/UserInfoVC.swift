//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by JC on 2/7/22.
//

import UIKit

class UserInfoVC: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let headerView = UIView()
    private let reposView = UIView()
    private let followersView = UIView()
    private let dateLb = GFBodyLabel(textAlignment: .center)
    private var itemViews: [UIView] = []
    
    private var username: String!
    private weak var delegate: FollowersListVCDelegate!
    
    init(username: String, delegate: FollowersListVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureScrollView()
        configureViews()
        getUserInfo()
    }
    
    private func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case.success(let user):
                DispatchQueue.main.async {
                    self.loadDataInViews(with: user)
                }
                
            case.failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue)
            }
        }
    }
    
    private func loadDataInViews(with user: User) {
        self.add(
            childVC: GFUserInfoHeaderVC(user: user),
            to: self.headerView
        )
        self.add(
            childVC: GFReposCardVC(user: user, delegate: self),
            to: self.reposView
        )
        self.add(
            childVC: GFFollowersCardVC(user: user, delegate: self),
            to: self.followersView
        )
        
        self.dateLb.text = "GitHub user since \(user.createdAt.toString(with: .medium))"
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneBt = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneBt
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
        itemViews = [headerView, reposView, followersView, dateLb]
        let padding: CGFloat = 20
        
        for itemView in itemViews {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            ])
        }
        
        let itemHeight: CGFloat = 140
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 220),
            
            reposView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            reposView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            followersView.topAnchor.constraint(equalTo: reposView.bottomAnchor, constant: padding),
            followersView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLb.topAnchor.constraint(equalTo: followersView.bottomAnchor, constant: padding),
            dateLb.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dateLb.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }

}

extension UserInfoVC: GFReposCardVCDelegate {
    
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Something went wrong", message: "Couldn't access the user's GitHub profile.")
            return
        }
        
        presentSafariVC(with: url)
    }
    
}

extension UserInfoVC: GFFollowersCardVCDelegate {
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No followers", message: "This user has no followers.")
            return
        }
        
        delegate.didRequestFollowers(for: user.username)
        dismissVC()
    }

}
