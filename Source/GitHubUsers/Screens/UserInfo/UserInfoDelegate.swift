//
//  UserInfoDelegate.swift
//  GitHubUsers
//
//  Created by JC on 5/3/23.
//

import Foundation

protocol UserInfoDelegate: AnyObject {
    func didTapGitHubProfile(for url: URL)
    func didTapFollowers(for userInfo: UserInfo)
    func didTapFollowing(for userInfo: UserInfo)
}
