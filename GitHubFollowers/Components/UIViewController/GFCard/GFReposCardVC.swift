//
//  GFReposCardVC.swift
//  GitHubFollowers
//
//  Created by JC on 3/7/22.
//

import UIKit

protocol GFReposCardVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
}

class GFReposCardVC: GFBaseCardVC {

    private weak var delegate: GFReposCardVCDelegate!
    
    init(user: User, delegate: GFReposCardVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    private func configureViews() {
        itemLeft.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemRight.set(itemInfoType: .repos, withCount: user.publicGists)
        actionBt.set(color: .systemPurple, title: "GitHub profile", image: SFSymbols.profile.image)
    }
    
    override func actionBtTapped() {
        delegate.didTapGitHubProfile(for: user)
    }

}
