//
//  UserListDelegate.swift
//  GitHubUsers
//
//  Created by JC on 5/3/23.
//

protocol UserListDelegate: AnyObject {
    func didRequestFollowers(for username: String)
    func didRequestFollowings(for username: String)
}
