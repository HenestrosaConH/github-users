//
//  UsersService.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 22/7/22.
//

import Foundation

protocol UsersServiceable {
    func getFollowers(for username: String, perPage: Int, page: Int) async -> Result<[User], GFNetworkError>
    func getFollowings(for username: String, perPage: Int, page: Int) async -> Result<[User], GFNetworkError>
    func getUserInfo(for username: String) async -> Result<UserInfo, GFNetworkError>
}

struct UsersService: HTTPClient, UsersServiceable {
    
    func getFollowers(for username: String, perPage: Int, page: Int) async -> Result<[User], GFNetworkError> {
        return await sendRequest(
            endpoint: UsersEndpoint.followers(username: username, perPage: perPage, page: page),
            responseType: [User].self
        )
    }
    
    func getFollowings(for username: String, perPage: Int, page: Int) async -> Result<[User], GFNetworkError> {
        return await sendRequest(
            endpoint: UsersEndpoint.following(username: username, perPage: perPage, page: page),
            responseType: [User].self
        )
    }
    
    func getUserInfo(for username: String) async -> Result<UserInfo, GFNetworkError> {
        return await sendRequest(
            endpoint: UsersEndpoint.userInfo(username: username),
            responseType: UserInfo.self
        )
    }
    
}
