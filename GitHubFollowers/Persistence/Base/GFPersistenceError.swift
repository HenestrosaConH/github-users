//
//  NetworkError.swift
//  GitHubFollowers
//
//  Created by JC on 29/6/22.
//

import Foundation

enum GFPersistenceError: String, Error {
    case unableToFavorite = "There was an error favoriting this user. Please, try again."
    case alreadyAdded = "You've already favorited this user."
}
