//
//  UsersService.swift
//  GitHubFollowers
//
//  Created by JC on 22/7/22.
//

import Foundation

protocol UsersServiceable {
    func getFollowers(for username: String, perPage: Int, page: Int) async -> Result<[Follower], GFNetworkError>
    func getUser(for username: String) async -> Result<User, GFNetworkError>
}

struct UsersService: HTTPClient, UsersServiceable {
    
    func getFollowers(for username: String, perPage: Int, page: Int) async -> Result<[Follower], GFNetworkError> {
        return await sendRequest(endpoint: UsersEndpoint.followers(username: username, perPage: perPage, page: page), responseType: [Follower].self)
    }
    
    func getUser(for username: String) async -> Result<User, GFNetworkError> {
        return await sendRequest(endpoint: UsersEndpoint.user(username: username), responseType: User.self)
    }
    
}
