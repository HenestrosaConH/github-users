//
//  Endpoints.swift
//  GitHubFollowers
//
//  Created by JC on 22/7/22.
//

import Foundation

enum UsersEndpoint {
    case user(username: String)
    case followers(username: String, perPage: Int, page: Int)
}

extension UsersEndpoint: Endpoint {
    
    var path: String {
        switch self {
        case .user(let username):
            return "/users/\(username)"
        case .followers(let username, _, _):
            return "/users/\(username)/followers"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .user:
            return nil
        case .followers(_, let perPage, let page):
            return [
                URLQueryItem(name: "per_page", value: "\(perPage)"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .user, .followers:
            return .get
        }
    }
    
    var header: [String: String]? {
        // let accessToken = "no access token needed for this project"
        
        switch self {
        case .user, .followers:
            return nil
        // If we actually needed a header, it would look similar to this:
        /*
         return [
             "Authorization": "Bearer \(accessToken)",
             "Content-Type": "application/json;charset=utf-8"
         ]
         */
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .user, .followers:
            return nil
        }
    }
}
