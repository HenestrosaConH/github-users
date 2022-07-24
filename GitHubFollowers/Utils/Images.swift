//
//  Constants.swift
//  GitHubFollowers
//
//  Created by JC on 3/7/22.
//

import UIKit

enum Images {
    case avatarPlaceholder
    case ghLogo
    case emptyStateLogo
    
    var image: UIImage {
        switch self {
        case .avatarPlaceholder: return (UIImage(named: "avatar-placeholder")!)
        case .ghLogo: return (UIImage(named: "gh-logo")!)
        case .emptyStateLogo: return (UIImage(named: "empty-state-logo")!)
        }
    }

}
