//
//  GFPersistenceError.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 29/6/22.
//

import Foundation

enum GFPersistenceError: Error {
    case unableToFavorite
    case unableToRemove
    case unableToGetFavorites
    
    var title: String {
        switch self {
        case .unableToFavorite, .unableToRemove, .unableToGetFavorites:
            return "title_generic_error".localized()
        }
    }
    
    var description: String {
        switch self {
        case .unableToFavorite:
            return "description_unable_to_favorite".localized()
        case .unableToRemove:
            return "description_unable_to_remove".localized()
        case .unableToGetFavorites:
            return "description_unable_to_get_favorites".localized()
        }
    }
}
