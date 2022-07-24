//
//  GFFollowersCardVC.swift
//  GitHubFollowers
//
//  Created by JC on 3/7/22.
//

import UIKit

protocol GFFollowersCardVCDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

class GFFollowersCardVC: GFBaseCardVC {

    private weak var delegate: GFFollowersCardVCDelegate!
    
    init(user: User, delegate: GFFollowersCardVCDelegate) {
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
        itemLeft.set(itemInfoType: .followers, withCount: user.followers)
        itemRight.set(itemInfoType: .following, withCount: user.following)
        actionBt.set(color: .systemGreen, title: "Get followers", image: SFSymbols.followers.image)
    }

    override func actionBtTapped() {
        delegate.didTapGetFollowers(for: user)
    }
    
}
