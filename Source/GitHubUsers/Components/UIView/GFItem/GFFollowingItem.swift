//
//  GFFollowingInfo.swift
//  GitHubUsers
//
//  Created by JC on 27/7/22.
//

import UIKit

protocol GFFollowingItemVCDelegate: AnyObject {
    func didTapFollowing(for userInfo: UserInfo)
}

class GFFollowingItem: GFBaseItem {
    
    // MARK: - Private Properties
    
    private var userInfo: UserInfo!
    private weak var delegate: GFFollowingItemVCDelegate!
    
    
    // MARK: - Initializers
    
    override init(itemInfoType: GFItemInfoType, with text: String) {
        super.init(itemInfoType: itemInfoType, with: text)
    }
    
    convenience init(
        itemInfoType: GFItemInfoType,
        with text: String,
        userInfo: UserInfo,
        delegate: GFFollowingItemVCDelegate
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
        delegate.didTapFollowing(for: userInfo)
    }
    
}
