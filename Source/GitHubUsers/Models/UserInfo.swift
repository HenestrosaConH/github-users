//
//  UserInfo.swift
//  GitHubUsers
//
//  Created by JC on 27/6/22.
//

import UIKit

struct UserInfo: Userable, Codable {
    // MARK: In JSON response
    var username: String
    var avatarUrl: URL
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: URL
    let following: Int
    let followers: Int
    let createdAt: Date
    
    // MARK: Not in JSON response
    var avatarImage: UIImage? = nil
    
    private enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatarUrl
        case name
        case location
        case bio
        case publicRepos
        case publicGists
        case htmlUrl
        case following
        case followers
        case createdAt
    }
}


// MARK: - Extensions

extension UserInfo {
    func toUser() -> User {
        return User(
            username: self.username,
            avatarUrl: self.avatarUrl,
            avatarImage: self.avatarImage
        )
    }
}

/*
JSON EXAMPLE:
-----------------------------------------------------------------------------
{
    "login": "HenestrosaConH",
    "id": 60482743,
    "node_id": "MDQ6VXNlcjYwNDgyNzQz",
    "avatar_url": "https://avatars.githubusercontent.com/u/60482743?v=4",
    "gravatar_id": "",
    "url": "https://api.github.com/users/HenestrosaConH",
    "html_url": "https://github.com/HenestrosaConH",
    "followers_url": "https://api.github.com/users/HenestrosaConH/followers",
    "following_url": "https://api.github.com/users/HenestrosaConH/following{/other_user}",
    "gists_url": "https://api.github.com/users/HenestrosaConH/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/HenestrosaConH/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/HenestrosaConH/subscriptions",
    "organizations_url": "https://api.github.com/users/HenestrosaConH/orgs",
    "repos_url": "https://api.github.com/users/HenestrosaConH/repos",
    "events_url": "https://api.github.com/users/HenestrosaConH/events{/privacy}",
    "received_events_url": "https://api.github.com/users/HenestrosaConH/received_events",
    "type": "User",
    "site_admin": false,
    "name": "José Carlos López",
    "company": null,
    "blog": "https://henestrosaconh.com/",
    "location": "127.0.0.1",
    "email": null,
    "hireable": null,
    "bio": "iOS & Android developer studying web development",
    "twitter_username": null,
    "public_repos": 18,
    "public_gists": 6,
    "followers": 4,
    "following": 0,
    "created_at": "2020-01-30T17:58:36Z",
    "updated_at": "2022-06-08T14:33:47Z"
}
*/
