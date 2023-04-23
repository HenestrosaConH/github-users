//
//  GFFollowerInfoView.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 27/7/22.
//

import UIKit

protocol GFFollowersItemViewDelegate: AnyObject {
    func didTapFollowers(for userInfo: UserInfo)
}

class GFFollowersItem: GFBaseItem {
    
    // MARK: Private Properties
    
    private var userInfo: UserInfo!
    private weak var delegate: GFFollowersItemViewDelegate!
    
    // MARK: - Initializers
    
    override init(itemInfoType: GFItemInfoType, with text: String) {
        super.init(itemInfoType: itemInfoType, with: text)
    }
    
    convenience init(
        itemInfoType: GFItemInfoType,
        with text: String,
        userInfo: UserInfo,
        delegate: GFFollowersItemViewDelegate
    ) {
        self.init(itemInfoType: itemInfoType, with: text)
        self.userInfo = userInfo
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrided Methods
    
    override func didTapItem() {
        delegate.didTapFollowers(for: userInfo)
    }
    
}
