//
//  Userable.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 27/6/22.
//

import UIKit

protocol Userable {
    // MARK: In JSON response
    var username: String { get }
    var avatarUrl: URL { get }
    
    // MARK: Not in JSON response
    var avatarImage: UIImage? { get set }
}
