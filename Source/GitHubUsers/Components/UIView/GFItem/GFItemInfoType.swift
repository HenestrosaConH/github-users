//
//  GFItemInfoType.swift
//  GitHubUsers
//
//  Created by JC on 27/7/22.
//

import UIKit

enum GFItemInfoType: String {
    case repos
    case gists
    case followers
    case following
    
    var name: String {
        switch self {
        case .repos:
            return "repos".localized()
        case .gists:
            return "Gists"
        case .followers:
            return "followers".localized()
        case .following:
            return "following".localized()
        }
    }
    
    var image: UIImage {
        switch self {
        case .repos:
            return SFSymbol.repos.image
        case .gists:
            return SFSymbol.gists.image
        case .followers:
            return SFSymbol.followers.image
        case .following:
            return SFSymbol.following.image
        }
    }
}
