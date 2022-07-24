//
//  GFRequestErrors.swift
//  GitHubFollowers
//
//  Created by JC on 22/7/22.
//

import Foundation

enum GFNetworkError: String, Error {
    case invalidUrl = "The URL is not correct."
    case invalidUsername = "The username provided is not valid."
    case uncompletedRequest = "Unable to complete your request. Please, check your Internet connection."
    case invalidResponse = "Invalid response from the server. Please, try again."
    case invalidData = "The data received from the server was invalid. Please, try again."
    case unauthorized = "This resource cannot be accessed."
    case unexpectedStatusCode = "Unexpected error when executing the network call."
    case noResponse = "No response retrieved from the server. Please, try again"
}
