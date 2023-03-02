//
//  Endpoints.swift
//  GitHubUsers
//
//  Created by JC on 22/7/22.
//

import Foundation

enum UsersEndpoint {
    case userInfo(username: String)
    case followers(username: String, perPage: Int, page: Int)
    case following(username: String, perPage: Int, page: Int)
}

extension UsersEndpoint: Endpoint {
    
    var path: String {
        switch self {
        case .userInfo(let username):
            return "/users/\(username)"
        case .followers(let username, _, _):
            return "/users/\(username)/followers"
        case .following(let username, _, _):
            return "/users/\(username)/following"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .userInfo:
            return nil
        case .followers(_, let perPage, let page), .following(_, let perPage, let page):
            return [
                URLQueryItem(name: "per_page", value: "\(perPage)"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .userInfo, .followers, .following:
            return .get
        }
    }
    
    var header: [String: String]? {
        switch self {
        case .userInfo, .followers, .following:
            return nil
        }
    }
    
    /*
    // If we actually needed a header, we would add something like this:
    var header: [String: String]? {
        let accessToken = "token"
        
        switch self {
        case .userInfo, .followers:
            return [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
     */
    
    var body: [String: String]? {
        switch self {
        case .userInfo, .followers, .following:
            return nil
        }
    }
    
}
