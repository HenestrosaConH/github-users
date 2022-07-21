//
//  SFSymbols.swift
//  GitHubFollowers
//
//  Created by JC on 19/7/22.
//

import UIKit

enum SFSymbols {
    case location
    case repos
    case gists
    case followers
    case following
    case confirm
    case profile
    
    var image: UIImage {
        switch self {
        case .location: return (UIImage(systemName: "mappin.and.ellipse")!)
        case .repos: return (UIImage(systemName: "folder")!)
        case .gists: return (UIImage(systemName: "text.alignleft")!)
        case .followers: return (UIImage(systemName: "person.2")!)
        case .following: return (UIImage(systemName: "heart")!)
        case .confirm: return (UIImage(systemName: "checkmark.circle")!)
        case .profile: return (UIImage(systemName: "person")!)
        }
    }
}
