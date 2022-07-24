//
//  Follower.swift
//  GitHubFollowers
//
//  Created by JC on 27/6/22.
//

import Foundation

struct Follower: Codable, Hashable {
    let username: String
    let avatarUrl: String
    
    // For the cells of the CollectionView
    func hash(into hasher: inout Hasher) {
        hasher.combine(username)
    }
    
    private enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatarUrl
    }
}
