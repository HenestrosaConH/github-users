//
//  User.swift
//  GitHubUsers
//
//  Created by JC on 25/7/22.
//

import UIKit

struct User: Userable {
    // MARK: In JSON response
    var username: String
    var avatarUrl: URL
    
    // MARK: Not in JSON response
    var avatarImage: UIImage?
}


// MARK: - Extensions

extension User: Codable {
    private enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatarUrl
    }
}

extension User: Hashable {
    // For the cells of the CollectionView
    func hash(into hasher: inout Hasher) {
        hasher.combine(username)
    }
}
