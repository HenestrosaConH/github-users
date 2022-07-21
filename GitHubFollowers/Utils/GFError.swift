//
//  NetworkError.swift
//  GitHubFollowers
//
//  Created by JC on 29/6/22.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "The username provided is not valid."
    case uncompletedRequest = "Unable to complete your request. Please, check your Internet connection."
    case invalidResponse = "Invalid response from the server. Please, try again."
    case invalidData = "The data received from the server was invalid. Please, try again."
    
    case unableToFavorite = "There was an error favoriting this user. Please, try again."
    case alreadyAdded = "You've already favorited this user."
}
