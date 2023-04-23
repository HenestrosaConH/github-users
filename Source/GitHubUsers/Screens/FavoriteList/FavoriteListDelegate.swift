//
//  FavoriteListDelegate.swift
//  GitHubUsers
//
//  Created by JC on 5/3/23.
//

import UIKit

protocol FavoriteListDelegate: AnyObject {
    func didSelectRow(at index: Int)
    func showError(title: String, message: String)
}
